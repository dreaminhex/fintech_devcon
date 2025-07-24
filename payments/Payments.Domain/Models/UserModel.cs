namespace Payments.Domain.Models;

using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

public class UserModel
{
    [BsonId]
    [BsonRepresentation(BsonType.String)]
    public string Id { get; set; } = default!;

    [BsonElement("userName")]
    public string UserName { get; set; } = default!;

    [BsonElement("emailAddress")]
    public string EmailAddress { get; set; } = default!;

    [BsonElement("password")]
    public string Password { get; set; } = default!;

    [BsonElement("loanAccounts")]
    public List<string> LoanAccounts { get; set; } = [];

    [BsonElement("paymentAccounts")]
    public List<string> PaymentAccounts { get; set; } = [];

    [BsonElement("roles")]
    public List<string> Roles { get; set; } = [];
}