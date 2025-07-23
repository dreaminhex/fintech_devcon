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

    [BsonElement("accounts")]
    public List<string> Accounts { get; set; } = [];

    [BsonElement("roles")]
    public List<string> Roles { get; set; } = [];
}