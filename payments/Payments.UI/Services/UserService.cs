namespace Payments.UI.Services;

public class UserService
{
    public string? UserId { get; private set; }
    public string? Username { get; private set; }
    public List<string> AccountIds { get; private set; } = new();

    public bool Login(string username, string password)
    {
        // Mock validation
        if (username == "demo" && password == "password")
        {
            UserId = "user123";
            Username = username;
            AccountIds = ["1", "2", "3"];
            return true;
        }
        return false;
    }

    public void Logout()
    {
        UserId = null;
        Username = null;
        AccountIds.Clear();
    }

    public bool IsLoggedIn => UserId != null;
}
