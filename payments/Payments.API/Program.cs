using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using GraphQL;
using GraphQL.Types;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Payments.API.Models;
using Payments.API.Queries;
using Payments.API.Schema;
using Payments.Domain.Models;
using Payments.Domain.Repositories;
using Payments.Domain.Settings;
using Payments.Domain.Types;

var builder = WebApplication.CreateBuilder(args);

builder.Configuration
    .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
    .AddJsonFile($"appsettings.{builder.Environment.EnvironmentName}.json", optional: true)
    .AddEnvironmentVariables();

builder.Services.Configure<MongoSettings>(builder.Configuration.GetSection("Mongo"));
builder.Services.Configure<RedisSettings>(builder.Configuration.GetSection("Redis"));
builder.Services.AddSingleton<UserRepository>();
builder.Services.AddSingleton<UserType>();
builder.Services.AddSingleton<UserQuery>();
builder.Services.AddSingleton<ISchema, UserSchema>();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Add GraphQL.NET services
builder.Services.AddGraphQL(g =>
{
    g.AddSystemTextJson();
    g.AddFederation(version: "2.3");
    g.AddGraphTypes(typeof(UserQuery).Assembly);
    g.AddSchema<UserSchema>();
    g.AddUserContextBuilder(httpContext =>
    {
        var context = new Dictionary<string, object?>();

        var authHeader = httpContext.Request.Headers.Authorization.FirstOrDefault();
        if (!string.IsNullOrWhiteSpace(authHeader) && authHeader.StartsWith("Bearer "))
        {
            var token = authHeader["Bearer ".Length..];

            var handler = new JwtSecurityTokenHandler();
            var jwt = handler.ReadJwtToken(token);

            var roles = jwt.Claims
                .Where(c => c.Type == "role" || c.Type == "roles")
                .Select(c => c.Value)
                .ToList();

            context["roles"] = string.Join(",", roles);

            var userId = jwt.Claims.FirstOrDefault(c => c.Type == "sub")?.Value;
            if (!string.IsNullOrEmpty(userId))
            {
                context["userId"] = userId;
            }
        }
        return context;
    });
});

// Allow any of our services to query this (dev only)
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policy =>
        policy.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod());
});

var app = builder.Build();
app.UseStaticFiles();
app.UseCors();

// User login endpoint
app.MapPost("/login", async (LoginRequest login, UserRepository repo) =>
{
    var user = await repo.GetUserByEmailAndPassword(login.EmailAddress, login.Password);

    if (user is null)
        return Results.Unauthorized();

    var tokenHandler = new JwtSecurityTokenHandler();
    var key = Encoding.ASCII.GetBytes("688159e9-ea80-800a-ab08-8c51afaec3c0"); // Use a secure key in a real app
    var tokenDescriptor = new SecurityTokenDescriptor
    {
        Subject = new ClaimsIdentity(
        [
            new Claim(ClaimTypes.NameIdentifier, user.Id),
            new Claim(ClaimTypes.Name, user.UserName),
            new Claim("roles", string.Join(",", user.Roles))
        ]),
        Expires = DateTime.UtcNow.AddHours(1),
        SigningCredentials = new SigningCredentials(
            new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
    };

    var token = tokenHandler.CreateToken(tokenDescriptor);
    var jwt = tokenHandler.WriteToken(token);

    // Return the user and the token.
    return Results.Ok(new
    {
        user = new
        {
            id = user.Id,
            userName = user.UserName,
            emailAddress = user.EmailAddress,
            roles = user.Roles,
            loanAccounts = user.LoanAccounts,
            paymentAccounts = user.PaymentAccounts
        },
        token = jwt
    });
});

// Keep-alive for GraphiQL to prevent errors
app.Use(async (context, next) =>
{
    if (context.Request.Method == "GET"
        && context.Request.Path == "/graphql"
        && !context.Request.Query.ContainsKey("query"))
    {
        context.Response.StatusCode = 204;
        return;
    }

    await next();
});

// Configure Swagger
app.UseSwagger();
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "Payments API V1");
    c.InjectStylesheet("/swagger-dark.css");
    c.DocumentTitle = "Payments API";
});

// Configure GraphiQL to use the schema and set the endpoint.
app.UseGraphQL<ISchema>();
app.UseGraphQLGraphiQL("/graphiql", new GraphQL.Server.Ui.GraphiQL.GraphiQLOptions
{
    GraphQLEndPoint = "/graphql"
});

// Publish the latest version to Redis.
var schema = app.Services.GetRequiredService<ISchema>();
var redisSettings = app.Services.GetRequiredService<IOptions<RedisSettings>>().Value;
await Publisher.PublishToRedisAsync(schema, redisSettings);

await app.RunAsync();
