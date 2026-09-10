using Microsoft.EntityFrameworkCore;
using ProyectoComunas.API.Endpoints;
using ProyectoComunas.Datos;
using ProyectoComunas.Datos.StoredProcedures;

var builder = WebApplication.CreateBuilder(args);

var connectionString =
    builder.Configuration.GetConnectionString("DefaultConnection")
    ?? throw new InvalidOperationException(
        "No se encontró la cadena de conexión 'DefaultConnection'.");

builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(connectionString));

builder.Services.AddScoped<RegionSP>();
builder.Services.AddScoped<ComunaSP>();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.MapRegionEndpoints();
app.MapComunaEndpoints();

app.Run();