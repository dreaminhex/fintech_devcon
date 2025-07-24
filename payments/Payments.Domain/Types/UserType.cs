namespace Payments.Domain.Types;

using GraphQL;
using GraphQL.Types;
using Payments.Domain.Models;
using Payments.Domain.Utilities;

public class UserType : ObjectGraphType<UserModel>
{
    public UserType()
    {
        Name = "User";
        Field(x => x.Id).Description("User ID").Resolve(context =>
        {
            if (!RoleUtils.IsFieldAccessible<UserModel>(context, nameof(UserModel.Id)))
                throw new ExecutionError("Access denied for this field.");

            return context.Source.Id;
        });

        Field(x => x.UserName).Description("User Name").Resolve(context =>
        {
            if (!RoleUtils.IsFieldAccessible<UserModel>(context, nameof(UserModel.UserName)))
                throw new ExecutionError("Access denied for this field.");

            return context.Source.UserName;
        });

        Field(x => x.EmailAddress).Description("Email Address").Resolve(context =>
        {
            if (!RoleUtils.IsFieldAccessible<UserModel>(context, nameof(UserModel.EmailAddress)))
                throw new ExecutionError("Access denied for this field.");

            return context.Source.EmailAddress;
        });

        Field(x => x.EmailAddress).Description("Password").Resolve(context =>
        {
            if (!RoleUtils.IsFieldAccessible<UserModel>(context, nameof(UserModel.Password)))
                throw new ExecutionError("Access denied for this field.");

            return context.Source.Password;
        });

        Field<ListGraphType<StringGraphType>>("accounts").Description("Accounts").Resolve(ctx => ctx.Source.Accounts).Resolve(context =>
        {
            if (!RoleUtils.IsFieldAccessible<UserModel>(context, nameof(UserModel.Accounts)))
                throw new ExecutionError("Access denied for this field.");

            return context.Source.Accounts;
        });

        Field<ListGraphType<StringGraphType>>("Roles").Description("Roles").Resolve(ctx => ctx.Source.Roles).Resolve(context =>
        {
            if (!RoleUtils.IsFieldAccessible<UserModel>(context, nameof(UserModel.Roles)))
                throw new ExecutionError("Access denied for this field.");

            return context.Source.Roles;
        });
    }
}
