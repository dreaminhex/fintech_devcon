namespace Payments.UI.Controllers;

using Microsoft.AspNetCore.Mvc;
using Payments.UI.Models;
using Payments.UI.Services;

[ApiController]
[Route("api/[controller]")]
public class LoginController(UserRepository repo) : ControllerBase
{
    [HttpPost]
    public async Task<ActionResult<UserModel>> Login(LoginRequest request)
    {
        var user = await repo.GetByEmailAndPassword(request.EmailAddress, request.Password);
        if (user == null)
            return Unauthorized();

        return Ok(user);
    }

    public class LoginRequest
    {
        public string EmailAddress { get; set; } = null!;
        public string Password { get; set; } = null!;
    }
}
