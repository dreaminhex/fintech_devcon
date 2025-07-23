namespace Payments.UI.Models;

using System.Text.Json.Serialization;

public class Account
{
    [JsonPropertyName("accountid")]
    public long AccountId { get; set; }

    [JsonPropertyName("accountnumber")]
    public string AccountNumber { get; set; } = "";

    [JsonPropertyName("accountname")]
    public string AccountName { get; set; } = "";

    [JsonPropertyName("balance")]
    public decimal Balance { get; set; }
}