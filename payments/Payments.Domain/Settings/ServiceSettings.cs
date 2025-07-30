namespace Payments.Domain.Settings;

public class ServiceSettings
{
    /// <summary>
    /// Payments service URL.
    /// </summary>
    public required string Payments { get; set; }

    /// <summary>
    /// Processor service URL.
    /// </summary>
    public required string Processor { get; set; }
}
