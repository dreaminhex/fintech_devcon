namespace Payments.API.Repositories;

using static System.Linq.Dynamic.Core.DynamicQueryableExtensions;
using static System.Linq.Queryable;
using Microsoft.Extensions.Options;
using MongoDB.Driver;
using MongoDB.Driver.Linq;
using Payments.API.Models;

public class UserRepository
{
    private readonly IMongoCollection<UserModel> users;

    public UserRepository(IOptions<MongoSettings> options)
    {
        var mongoSettings = options.Value;
        var client = new MongoClient(mongoSettings.ConnectionString);
        var db = client.GetDatabase(mongoSettings.Database);
        users = db.GetCollection<UserModel>("users");
    }

    public async Task<List<UserModel>> GetFilteredUsersAsync(string? where, string? sort, int? skip, int? take)
    {
        var query = users.AsQueryable();

        if (!string.IsNullOrWhiteSpace(where))
            query = query.Where(where);

        if (!string.IsNullOrWhiteSpace(sort))
            query = query.OrderBy(sort);

        if (skip.HasValue)
            query = query.Skip(skip.Value);

        if (take.HasValue)
            query = query.Take(take.Value);

        return await Task.Run(() => query.ToList());
    }

    public async Task<UserModel?> GetUserByEmailAndPassword(string email, string password)
    {
        return await users
            .Find(u => u.EmailAddress == email && u.Password == password)
            .FirstOrDefaultAsync();
    }
}
