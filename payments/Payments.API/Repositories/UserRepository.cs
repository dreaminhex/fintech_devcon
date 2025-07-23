namespace Payments.API.Repositories;

using MongoDB.Driver;
using Payments.API.Models;

public class UserRepository
{
    private readonly IMongoCollection<UserModel> users;

    public UserRepository()
    {
        var client = new MongoClient("mongodb://localhost:27017");
        var db = client.GetDatabase("fintech_devcon");
        users = db.GetCollection<UserModel>("users");
    }

    public async Task<UserModel?> GetUserByEmailAndPassword(string email, string password)
    {
        return await users
            .Find(u => u.EmailAddress == email && u.Password == password)
            .FirstOrDefaultAsync();
    }

    public async Task<UserModel?> GetUserById(string id)
    {
        return await users
            .Find(u => u.Id == id)
            .FirstOrDefaultAsync();
    }
}
