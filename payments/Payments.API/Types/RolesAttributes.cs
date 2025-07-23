namespace Payments.API.Types;

[AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
public class RolesAttribute(params string[] allowedRoles) : Attribute
{
    public string[] AllowedRoles { get; } = allowedRoles;
}

