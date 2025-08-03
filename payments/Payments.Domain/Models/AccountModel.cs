namespace Payments.Domain.Models;

using System.Text.Json.Serialization;
using Payments.Domain.Types;

public class AccountModel
{
    [JsonPropertyName("accountid")]
    public long AccountId { get; set; } = 0L;

    [JsonPropertyName("accounttoken")]
    public string AccountToken { get; set; } = "";

    [JsonPropertyName("accountname")]
    public string AccountName { get; set; } = "";

    [JsonPropertyName("accountlast4")]
    public int AccountLast4 { get; set; }

    [JsonPropertyName("accountexpmonth")]
    public int AccountExpMonth { get; set; }

    [JsonPropertyName("accountexpmonth")]
    public int AccountExpYear { get; set; }

    [JsonPropertyName("balance")]
    public decimal Balance { get; set; } = 0m;

    [JsonPropertyName("accounttype")]
    public AccountType AccountType { get; set; } = AccountType.Card;
}