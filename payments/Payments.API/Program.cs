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
using Payments.API.Types;
using Payments.Domain.Repositories;
using Payments.Domain.Settings;

var builder = WebApplication.CreateBuilder(args);

builder.Services.Configure<MongoSettings>(builder.Configuration.GetSection("Mongo"));
builder.Services.Configure<RedisSettings>(builder.Configuration.GetSection("Redis"));
builder.Services.AddSingleton<UserRepository>();
builder.Services.AddSingleton<UserType>();
builder.Services.AddSingleton<UserQuery>();
builder.Services.AddSingleton<ISchema, UserSchema>();

// Add GraphQL.NET services
builder.Services.AddGraphQL(g =>
{
    g.AddSystemTextJson();
    g.AddFederation(version: "2.3");
    g.AddGraphTypes(typeof(UserQuery).Assembly);
    g.AddSchema<UserSchema>();
});

// Allow any of our services to query this (dev only)
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policy =>
        policy.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod());
});

var app = builder.Build();
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
            roles = user.Roles
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
