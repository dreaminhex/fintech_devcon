namespace Payments.API.Schema;

using GraphQL;
using GraphQL.Types;
using Payments.Domain.Models;
using StackExchange.Redis;

public static class Publisher
{
    public static async Task PublishToRedisAsync(string sdl, RedisSettings settings)
    {
        var redis = await ConnectionMultiplexer.ConnectAsync(settings.ConnectionString);
        var db = redis.GetDatabase();
        await db.StringSetAsync($"{settings.FederationKey}:schema", sdl);
        await db.StringSetAsync($"{settings.FederationKey}:url", settings.ServiceUrl);
    }
}
