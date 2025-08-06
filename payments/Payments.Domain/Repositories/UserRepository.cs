namespace Payments.Domain.Repositories;

using static System.Linq.Dynamic.Core.DynamicQueryableExtensions;
using static System.Linq.Queryable;
using MongoDB.Driver;
using MongoDB.Driver.Linq;
using Payments.Domain.Models;
using Payments.Domain.Settings;
using Microsoft.Extensions.Options;

public class UserRepository
{
    public readonly IMongoCollection<UserModel> users;

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
