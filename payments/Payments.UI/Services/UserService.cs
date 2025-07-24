namespace Payments.UI.Services;

using System.Net.Http.Json;
using Payments.Domain.Models;
using Payments.UI.Models;

public class UserService(HttpClient client)
{
    public UserModel? User { get; private set; }
    public string? Token { get; set; }

    public async Task LoginAsync(string emailAddress, string password)
    {
        // Call the Payments API endpoint to login
        var response = await client.PostAsJsonAsync("http://dotnet-payments-api:2022/login", new { emailAddress, password });

        if (response.IsSuccessStatusCode)
        {
            var loginResponse = await response.Content.ReadFromJsonAsync<LoginResponse>();

            if (loginResponse?.User is not null)
            {
                this.User = loginResponse.User;
                this.Token = loginResponse.Token;
            }
        }
    }

    public void Logout()
    {
        this.User = null;
    }

    public bool IsLoggedIn => this.User != null;
}
