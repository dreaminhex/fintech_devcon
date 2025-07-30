using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using Payments.Domain.Repositories;
using Payments.Domain.Settings;
using Payments.UI;
using Payments.UI.Models;
using Payments.UI.Services;

var builder = WebAssemblyHostBuilder.CreateDefault(args);

var serviceSettings = builder.Configuration
    .GetSection("Services")
    .Get<ServiceSettings>() ?? throw new InvalidOperationException("Missing 'Services' section in configuration.");

builder.Services.AddSingleton(serviceSettings);

builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");

builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri(builder.HostEnvironment.BaseAddress) });
builder.Services.AddSingleton<UserRepository>();
builder.Services.AddScoped<UserSession>();
builder.Services.AddScoped<UserService>();
builder.Services.AddScoped<AccountService>();

await builder.Build().RunAsync();
