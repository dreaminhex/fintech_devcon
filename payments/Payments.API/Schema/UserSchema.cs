namespace Payments.API.Schema;

using Payments.API.Queries;

public class UserSchema : GraphQL.Types.Schema
{
    public UserSchema(IServiceProvider provider) : base(provider)
    {
        Query = provider.GetRequiredService<UserQuery>();
    }
}
