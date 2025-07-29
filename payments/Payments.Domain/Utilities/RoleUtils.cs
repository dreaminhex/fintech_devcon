using System.Reflection;
using GraphQL;
using Payments.Domain.Types;

namespace Payments.Domain.Utilities;

public static class RoleUtils
{
    public static bool IsFieldAccessible<TSource>(
        IResolveFieldContext context,
        string propertyName)
    {
        var roles = context.UserContext is IDictionary<string, object> dict &&
                    dict.TryGetValue("roles", out var value) &&
                    value is string roleString
                        ? roleString.Split(',').Select(r => r.Trim()).ToList()
                        : [];

        var prop = typeof(TSource).GetProperty(propertyName);
        if (prop == null) return false;

        var attr = prop.GetCustomAttribute<RolesAttribute>();

        if (attr == null) return true; // No restriction means public

        return attr.AllowedRoles.Any(allowed =>
            roles.Contains(allowed, StringComparer.OrdinalIgnoreCase));
    }
}
