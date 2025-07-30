namespace Payments.UI.Services;

using System.Net.Http.Json;
using Payments.Domain.Models;
using Payments.Domain.Settings;
using Payments.Domain.Types;

public class AccountService(ServiceSettings settings, HttpClient client)
{
    public async Task<List<AccountModel>> GetLoanAccountsByAccountIds(List<string> accountIds)
    {
        return await GetAccountsByType(accountIds, AccountType.PayTo);
    }

    public async Task<List<AccountModel>> GetPaymentAccountsByAccountIds(List<string> accountIds)
    {
        return await GetAccountsByType(accountIds, AccountType.PayFrom);
    }

    private async Task<List<AccountModel>> GetAccountsByType(List<string> accountIds, AccountType targetType)
    {
        var response = await client.PostAsJsonAsync($"{settings.Processor}/account", new
        {
            accountnumbers = accountIds
        });

        if (!response.IsSuccessStatusCode)
            return [];

        var accounts = await response.Content.ReadFromJsonAsync<List<AccountModel>>();
        return accounts?
            .Where(a => a.AccountType == targetType)
            .ToList() ?? [];
    }
}
