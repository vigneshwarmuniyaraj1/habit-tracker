using HabitTracker.Api.Data;
using HabitTracker.Api.Entities;
using HabitTracker.Api.Models.Dtos;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace HabitTracker.Api.Services;

public class AuthService : IAuthService
{
    private readonly AppDbContext _db;
    private readonly IConfiguration _config;

    public AuthService(AppDbContext db, IConfiguration config)
    {
        _db = db;
        _config = config;
    }

    public async Task<AuthResponse?> RegisterAsync(RegisterRequest request)
    {
        // check if email is already used
        var existingUser = await _db.Users.FirstOrDefaultAsync(u => u.Email == request.Email);
        if (existingUser != null)
            return null; // email already taken

        // scramble the password before saving (never save plain text password!)
        var hashedPassword = BCrypt.Net.BCrypt.HashPassword(request.Password);

        var newUser = new User
        {
            Email = request.Email,
            Username = request.Email,
            PasswordHash = hashedPassword
        };

        _db.Users.Add(newUser);
        await _db.SaveChangesAsync();

        var token = GenerateJwtToken(newUser);

        return new AuthResponse
        {
            Token = token,
            Email = newUser.Email,
            UserId = newUser.Id
        };
    }

    public async Task<AuthResponse?> LoginAsync(LoginRequest request)
    {
        var user = await _db.Users.FirstOrDefaultAsync(u => u.Email == request.Email);
        if (user == null)
            return null; // no user with this email

        // check if the entered password matches the saved (hashed) password
        bool isPasswordCorrect = BCrypt.Net.BCrypt.Verify(request.Password, user.PasswordHash);
        if (!isPasswordCorrect)
            return null; // wrong password

        var token = GenerateJwtToken(user);

        return new AuthResponse
        {
            Token = token,
            Email = user.Email,
            UserId = user.Id
        };
    }

    // this creates the actual JWT token (the "digital pass")
    private string GenerateJwtToken(User user)
    {
        var claims = new[]
        {
            new Claim(JwtRegisteredClaimNames.Sub, user.Id.ToString()),
            new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
            new Claim(JwtRegisteredClaimNames.Email, user.Email)
        };

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]!));
        var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

        var token = new JwtSecurityToken(
            issuer: _config["Jwt:Issuer"],
            audience: _config["Jwt:Audience"],
            claims: claims,
            expires: DateTime.UtcNow.AddMinutes(double.Parse(_config["Jwt:ExpiresInMinutes"]!)),
            signingCredentials: creds
        );

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}
