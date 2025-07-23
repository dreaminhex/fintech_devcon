using Payments.Domain.Models;

namespace Payments.UI.Models;

public class UserSession
{
    public UserModel? User { get; private set; }

    public bool IsLoggedIn => User != null;

    public void SetUser(UserModel user) => User = user;

    public void Logout() => User = null;
}


