using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using Payments.UI;
using Payments.UI.Models;
using Payments.UI.Services;

var builder = WebAssemblyHostBuilder.CreateDefault(args);

builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");

var mongoSettings = builder.Configuration.GetSection("Mongo").Get<MongoSettings>();

if (mongoSettings == null)
{
    throw new Exception("Missing MongoDB settings.");
}

builder.Services.AddSingleton(new UserRepository(mongoSettings));
builder.Services.AddSingleton<UserRepository>();

builder.Services.AddScoped<UserSession>();
builder.Services.AddSingleton<UserService>();
builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri(builder.HostEnvironment.BaseAddress) });

await builder.Build().RunAsync();
