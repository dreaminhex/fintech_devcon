using System.Net.Http.Json;
using Payments.UI.Models;

namespace Payments.UI.Services;

public class UserService
{
    public string? UserId { get; private set; }
    public string? Username { get; private set; }
    public List<string> Accounts { get; private set; } = [];

    public async Task<UserModel?> LoginAsync(string emailAddress, string password, HttpClient http)
    {
        var response = await http.PostAsJsonAsync("http://localhost:5000/api/login", new { emailAddress, password });
        if (!response.IsSuccessStatusCode) return null;

        var user = await response.Content.ReadFromJsonAsync<UserModel>();
        
        return user;
    }

    public void Logout()
    {
        UserId = null;
        Username = null;
        Accounts.Clear();
    }

    public bool IsLoggedIn => UserId != null;
}
