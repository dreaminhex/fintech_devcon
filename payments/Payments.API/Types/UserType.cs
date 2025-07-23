namespace Payments.API.Types;

using GraphQL.Types;
using Payments.Domain.Models;

public class UserType : ObjectGraphType<UserModel>
{
    public UserType()
    {
        Name = "User";
        Field(x => x.Id).Description("User ID");
        Field(x => x.UserName).Description("Username");
        Field(x => x.EmailAddress).Description("Email");
        Field<ListGraphType<StringGraphType>>("accounts").Resolve(ctx => ctx.Source.Accounts);
    }
}
