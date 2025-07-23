using GraphQL;
using GraphQL.Types;
using Microsoft.Extensions.Options;
using Payments.API.Models;
using Payments.API.Queries;
using Payments.API.Repositories;
using Payments.API.Schema;
using Payments.API.Types;

var builder = WebApplication.CreateBuilder(args);

builder.Services.Configure<MongoSettings>(builder.Configuration.GetSection("Mongo"));
builder.Services.Configure<RedisSettings>(builder.Configuration.GetSection("Redis"));
builder.Services.AddSingleton<UserRepository>();
builder.Services.AddSingleton<UserType>();
builder.Services.AddSingleton<UserQuery>();
builder.Services.AddSingleton<ISchema, UserSchema>();

builder.Services.AddGraphQL(g =>
{
    g.AddSystemTextJson();
    g.AddFederation(version: "2.3");
    g.AddGraphTypes(typeof(UserQuery).Assembly);
    g.AddSelfActivatingSchema<UserSchema>();
});

builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policy =>
        policy.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod());
});

var app = builder.Build();
app.UseCors();

app.MapPost("/login", async (LoginRequest login, UserRepository repo) =>
{
    var user = await repo.GetUserByEmailAndPassword(login.EmailAddress, login.Password);
    return user is not null ? Results.Ok(user) : Results.Unauthorized();
});

app.UseGraphQL<ISchema>();
app.UseGraphQLGraphiQL("/graphiql", new GraphQL.Server.Ui.GraphiQL.GraphiQLOptions
{
    GraphQLEndPoint = "/graphql"
});

var schema = app.Services.GetRequiredService<ISchema>();
var redisSettings = app.Services.GetRequiredService<IOptions<RedisSettings>>().Value;
await Publisher.PublishToRedisAsync(schema, redisSettings);

await app.RunAsync();
