namespace Payments.API.Models;

public class LoginRequest
{
    public string EmailAddress { get; set; } = null!;
    public string Password { get; set; } = null!;
}
