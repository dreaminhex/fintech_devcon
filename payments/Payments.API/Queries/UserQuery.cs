namespace Payments.API.Queries;

using GraphQL;
using GraphQL.Types;
using Payments.API.Repositories;
using Payments.API.Types;

public class UserQuery : ObjectGraphType
{
    public UserQuery(UserRepository repo)
    {
        Field<ListGraphType<UserType>>("users")
            .Description("Returns filtered, sorted, paged list of users")
            .Arguments(
                new QueryArguments(
                    new QueryArgument<StringGraphType> { Name = "where" },
                    new QueryArgument<StringGraphType> { Name = "sort" },
                    new QueryArgument<IntGraphType> { Name = "skip" },
                    new QueryArgument<IntGraphType> { Name = "take" }
                )
            )
            .ResolveAsync(async ctx =>
            {
                var where = ctx.GetArgument<string?>("where");
                var sort = ctx.GetArgument<string?>("sort");
                var skip = ctx.GetArgument<int?>("skip");
                var take = ctx.GetArgument<int?>("take");

                return await repo.GetFilteredUsersAsync(where, sort, skip, take);
            });
    }
}