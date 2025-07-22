namespace Payments.UI.Models;

public class UserModel
{
    public string Id { get; set; } = default!;
    public string UserName { get; set; } = default!;
    public string EmailAddress { get; set; } = default!;
    public string Password { get; set; } = default!;
    public List<string> Accounts { get; set; } = new();
}