namespace Payments.API.Schema;

using Payments.API.Queries;
using Payments.API.Types;

public class UserSchema : GraphQL.Types.Schema
{
    public UserSchema(IServiceProvider provider) : base(provider)
    {
        Query = provider.GetRequiredService<UserQuery>();
    }
}
