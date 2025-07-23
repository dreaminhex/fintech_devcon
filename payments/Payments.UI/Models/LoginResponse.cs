using Payments.Domain.Models;

namespace Payments.UI.Models;

public class LoginResponse
{
    public UserModel User { get; set; } = default!;
    public string Token { get; set; } = string.Empty;
}
