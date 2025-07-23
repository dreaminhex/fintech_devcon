namespace Payments.API.Queries;

using GraphQL;
using GraphQL.Types;
using Payments.API.Repositories;
using Payments.API.Types;

public class UserQuery : ObjectGraphType
{
    public UserQuery(UserRepository repo)
    {
        Field<UserType>("userById")
            .Arguments(new QueryArguments(new QueryArgument<NonNullGraphType<StringGraphType>> { Name = "id" }))
            .ResolveAsync(async ctx => await repo.GetUserById(ctx.GetArgument<string>("id")));
    }
}