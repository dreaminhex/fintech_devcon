namespace Payments.API.Queries;

using GraphQL;
using GraphQL.Types;
using Payments.API.Types;
using Payments.API.Utilities;
using Payments.Domain.Repositories;

public class UserQuery : ObjectGraphType
{
    public UserQuery(UserRepository repo)
    {
        // This is a simple implementation that parses a .NET LINQ query. There are deeper, more complex
        // implementations that will provide better intellisense (like with HotChocolate), but this demonstrates
        // the basic core of filtering, sorting, and paging, with no additional overhead.
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
                // Check that a user is authenticated and has roles.
                AuthUtils.RequireAuth(ctx);

                /* NOTE: Add additional checks here on roles to ensure the role can even access this query.
                Example: 
                    AuthUtils.RequireRole(ctx, "Admin");
                */

                var where = ctx.GetArgument<string?>("where");
                var sort = ctx.GetArgument<string?>("sort");
                var skip = ctx.GetArgument<int?>("skip");
                var take = ctx.GetArgument<int?>("take");

                return await repo.GetFilteredUsersAsync(where, sort, skip, take);
            });
    }
}