using System.Text.Json.Serialization;

namespace Payments.Domain.Models;

public class PaymentModel
{
    [JsonPropertyName("paymentid")]
    public long PaymentId { get; set; }

    [JsonPropertyName("userid")]
    public string UserId { get; set; } = "";

    [JsonPropertyName("loanid")]
    public string LoanId { get; set; } = "";

    [JsonPropertyName("accounttoken")]
    public string AccountToken { get; set; } = "";

    [JsonPropertyName("amount")]
    public decimal PaymentAmount { get; set; }

    [JsonPropertyName("paymentdate")]
    public DateTime PaymentDate { get; set; }
}
