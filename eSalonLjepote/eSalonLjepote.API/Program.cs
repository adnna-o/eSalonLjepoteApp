using eSaljonLjepote.Services.Service;
using eSalonLjepote.API;
using eSalonLjepote.API.Filters;
using eSalonLjepote.Service.Database;
using eSalonLjepote.Service.Service;
using eSalonLjepote.Service.Service;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Server.Kestrel.Core;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using Newtonsoft.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);



// Add services to the container.

//builder.Services.AddTransient<IKorisnikService, KorisnikService>();
builder.Services.AddTransient<IKorisnikService, KorisnikService>();

builder.Services.AddTransient<IAdministratorService, AdministratorService>();
builder.Services.AddTransient<IUslugaService, UslugaService>();
builder.Services.AddTransient<IZaposleniService, ZaposleniService>();
builder.Services.AddTransient<IUlogaService, UlogaService>();
builder.Services.AddTransient<IKlijentiService, KlijentiService>();
builder.Services.AddTransient<ITerminiService, TerminiService>();
builder.Services.AddTransient<IRadnoVrijemeService, RadnoVrijemeService>();
builder.Services.AddTransient<ISalonLjepoteService, SalonLjepoteService>();
builder.Services.AddTransient<IProizvodService, ProizvodiService>();
builder.Services.AddTransient<IRecenzijeService, RecenzijeService>();
builder.Services.AddTransient<IPlacanjeService, PlacanjeService>();
builder.Services.AddTransient<IGalerijaService, GalerijaService>();
builder.Services.AddTransient<INovostiService, NovostiService>();
builder.Services.AddTransient<IKorisnikUlogaService, KorisnikUlogaService>();
builder.Services.AddTransient<INarudzbaService, NarudzbaService>();
builder.Services.AddTransient<IKorpaService, KorpaService>();
builder.Services.AddTransient<IOcjeneProizvodaService, OcjeneProizvodaService>();




builder.Services.AddControllers()
    .AddNewtonsoftJson(options =>
    {
        options.SerializerSettings.ContractResolver = new Newtonsoft.Json.Serialization.DefaultContractResolver();
    });

builder.Services.AddControllers(x =>
{
    x.Filters.Add<ErrorFilter>();
});
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("Basic", new OpenApiSecurityScheme
    {
        Type = SecuritySchemeType.Http,
        Scheme = "basic"
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement()
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Basic"
                }
            },
            new string[] {}
        }
    });
});
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<ESalonLjepoteContext>(options => options.UseSqlServer(connectionString));


builder.Services.AddAutoMapper(typeof(IKorisnikService));

builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

builder.Services.AddControllers().AddNewtonsoftJson(options =>
{
    options.SerializerSettings.ContractResolver = new DefaultContractResolver
    {
        NamingStrategy = new CamelCaseNamingStrategy()
    };
    options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore;
});


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
