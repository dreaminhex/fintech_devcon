namespace Payments.UI.Services;

using System.Net.Http.Json;
using Payments.Domain.Models;
using Payments.Domain.Settings;
using Payments.UI.Models;

public class UserService(ServiceSettings settings, HttpClient client)
{
    public UserModel? User { get; private set; }
    public string? Token { get; set; }

    public async Task LoginAsync(string emailAddress, string password)
    {
        var response = await client.PostAsJsonAsync($"{settings.Payments}/login", new { emailAddress, password });

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
