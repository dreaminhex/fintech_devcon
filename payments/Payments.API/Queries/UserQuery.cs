namespace Payments.API.Queries;

using MongoDB.Driver;
using Payments.Domain.Models;
using Payments.Domain.Repositories;

public class UserQuery
{
    [UseFiltering]
    [UseSorting]
    public IQueryable<UserModel> GetUsers([Service] UserRepository repo)
    {
        return repo.users.AsQueryable();
    }
}
