using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Payments.Domain.Models;

public class RoleModel
{
    [BsonId]
    [BsonRepresentation(BsonType.String)]
    public required string Id { get; set; }

    [BsonElement("name")]
    public required string Name { get; set; }

    [BsonElement("description")]
    public required string Description { get; set; }
}
