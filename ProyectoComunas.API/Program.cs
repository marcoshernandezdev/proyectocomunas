using System.Text.Json;
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using ProyectoComunas.API.Endpoints;
using ProyectoComunas.Datos;
using ProyectoComunas.Datos.Configuration;
using ProyectoComunas.Datos.StoredProcedures;

var builder = WebApplication.CreateBuilder(args);

var connectionString =
    builder.Configuration.GetConnectionString("DefaultConnection")
    ?? throw new InvalidOperationException(
        "No se encontró la cadena de conexión 'DefaultConnection'.");

builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(connectionString));

// Bind StoredProcedureNames from configuration and validate
builder.Services.Configure<StoredProcedureNames>(
    builder.Configuration.GetSection("StoredProcedures"));
builder.Services.AddSingleton(sp =>
{
    var options = sp.GetRequiredService<IOptions<StoredProcedureNames>>().Value;
    options.Validate();
    return options;
});

builder.Services.AddScoped<RegionSP>();
builder.Services.AddScoped<ComunaSP>();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Global exception handler that returns a simple JSON message and logs the error
app.UseExceptionHandler(errorApp =>
{
    errorApp.Run(async context =>
    {
        var logger = context.RequestServices.GetRequiredService<ILogger<Program>>();
        var feature = context.Features.Get<IExceptionHandlerFeature>();
        if (feature?.Error is not null)
        {
            logger.LogError(feature.Error, "Unhandled exception");
        }

        context.Response.StatusCode = StatusCodes.Status500InternalServerError;
        context.Response.ContentType = "application/json";

        var payload = JsonSerializer.Serialize(new { mensaje = "Ocurrió un error inesperado." });
        await context.Response.WriteAsync(payload);
    });
});

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.MapRegionEndpoints();
app.MapComunaEndpoints();

app.Run();