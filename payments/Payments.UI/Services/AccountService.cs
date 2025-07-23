namespace Payments.UI.Services;

using System.Net.Http.Json;
using Payments.UI.Models;

public class AccountService(HttpClient client)
{
    public async Task<List<Account>> GetAccountsByAccountIds(List<string> accountIds)
    {
        var response = await client.PostAsJsonAsync("http://localhost:2024/account",
            new { accountnumbers = accountIds }
        );

        if (!response.IsSuccessStatusCode)
        {
            return [];
        }

        var accounts = await response.Content.ReadFromJsonAsync<List<Account>>();
        return accounts ?? [];
    }
}
