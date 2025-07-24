namespace Payments.Domain.Utilities;

using GraphQL;

public static class AuthUtils
{
    public static List<string> GetRoles(IResolveFieldContext ctx)
    {
        return ctx.UserContext is IDictionary<string, object> dict &&
               dict.TryGetValue("roles", out var value) &&
               value is string roleString
                   ? roleString.Split(',').Select(r => r.Trim()).ToList()
                   : [];
    }

    public static void RequireAuth(IResolveFieldContext ctx)
    {
        if (GetRoles(ctx).Count == 0)
            throw new ExecutionError("Authentication required.");
    }

    public static void RequireRole(IResolveFieldContext ctx, params string[] allowedRoles)
    {
        var roles = GetRoles(ctx);
        if (!allowedRoles.Any(role => roles.Contains(role, StringComparer.OrdinalIgnoreCase)))
        {
            throw new ExecutionError($"Access denied. Requires one of: {string.Join(", ", allowedRoles)}");
        }
    }
}

