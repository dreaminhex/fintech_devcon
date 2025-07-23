namespace Payments.UI.Services;

using System.Net.Http.Json;
using Payments.UI.Models;

public class UserService(HttpClient client)
{
    public UserModel? User { get; private set; }

    public async Task LoginAsync(string emailAddress, string password)
    {
        // Call the Payments API endpoint to login
        var response = await client.PostAsJsonAsync("http://localhost:2022/login", new { emailAddress, password });

        if (response.IsSuccessStatusCode)
        {
            var user = await response.Content.ReadFromJsonAsync<UserModel>();

            if (user != null)
            {
                this.User = user;
            }
        }
    }

    public void Logout()
    {
        this.User = null;
    }

    public bool IsLoggedIn => this.User != null;
}
