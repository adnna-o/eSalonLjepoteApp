using eSaljonLjepote.Services.Service;
using eSalonLjepote.Service.Database;
using eSalonLjepote.Service.Service;
using eSalonLjepote.Services.Service;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);



// Add services to the container.

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


builder.Services.AddAutoMapper(typeof(IKorisnikService));

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<ESalonLjepoteContext>(options => options.UseSqlServer(connectionString));



builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
