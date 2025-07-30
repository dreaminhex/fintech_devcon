namespace Payments.Domain.Models;

public class RedisSettings
{
    public string ConnectionString { get; set; } = default!;
    public string FederationKey { get; set; } = default!;
    public string ServiceUrl { get; set; } = default!;
}
