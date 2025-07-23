namespace Payments.API.Schema;

using GraphQL;
using GraphQL.Types;
using Payments.API.Models;
using StackExchange.Redis;

public static class Publisher
{
    public static async Task PublishToRedisAsync(ISchema schema, RedisSettings settings)
    {
        var redis = await ConnectionMultiplexer.ConnectAsync(settings.ConnectionString);
        var db = redis.GetDatabase();
        var sdl = schema.Print();
        await db.StringSetAsync($"{settings.FederationKey}:schema", sdl);
        await db.StringSetAsync($"{settings.FederationKey}:url", settings.Url);
    }
}
