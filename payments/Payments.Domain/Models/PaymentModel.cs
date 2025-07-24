using System.Text.Json.Serialization;

namespace Payments.Domain.Models;

public class PaymentModel
{
    [JsonPropertyName("paymentid")]
    public long PaymentId { get; set; }

    [JsonPropertyName("paytoaccount")]
    public string PayToAccountNumber { get; set; } = "";

    [JsonPropertyName("payfromaccount")]
    public string PayFromAccountNumber { get; set; } = "";

    [JsonPropertyName("amount")]
    public decimal PaymentAmount { get; set; }

    [JsonPropertyName("paymentdate")]
    public DateTime PaymentDate { get; set; }
}
