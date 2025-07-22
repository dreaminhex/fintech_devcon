namespace Payments.UI.Services;

using Microsoft.Extensions.Options;
using MongoDB.Driver;
using Payments.UI.Models;

public class UserRepository
{
    private readonly IMongoCollection<UserModel> _users;

    public UserRepository(MongoSettings settings)
    {
        var client = new MongoClient(settings.ConnectionString);
        var db = client.GetDatabase(settings.Database);
        _users = db.GetCollection<UserModel>("users");
    }

    public async Task<UserModel?> GetByEmailAndPassword(string email, string password)
    {
        return await _users
            .Find(u => u.EmailAddress == email && u.Password == password)
            .FirstOrDefaultAsync();
    }
}
