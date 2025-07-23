namespace Payments.API.Models;

public class RedisSettings
{
    public string ConnectionString { get; set; } = default!;
    public string FederationKey { get; set; } = default!;
    public string Url { get; set; } = default!;
}
