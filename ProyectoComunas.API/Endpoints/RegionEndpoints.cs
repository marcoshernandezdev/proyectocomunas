using ProyectoComunas.Datos.StoredProcedures;

namespace ProyectoComunas.API.Endpoints;

public static class RegionEndpoints
{
    public static IEndpointRouteBuilder MapRegionEndpoints(
        this IEndpointRouteBuilder app)
    {
        var group = app
            .MapGroup("/api/region")
            .WithTags("Regiones");

        group.MapGet("/", async (
            RegionSP regionSP,
            CancellationToken cancellationToken) =>
        {
            var regiones =
                await regionSP.ObtenerTodosAsync(cancellationToken);

            return Results.Ok(regiones);
        })
        .WithName("ObtenerRegiones")
        .WithSummary("Obtiene todas las regiones")
        .Produces(StatusCodes.Status200OK);

        group.MapGet("/{idRegion:int}", async (
            int idRegion,
            RegionSP regionSP,
            CancellationToken cancellationToken) =>
        {
            if (idRegion <= 0)
            {
                return Results.BadRequest(new
                {
                    mensaje = "El identificador de la región debe ser mayor que cero."
                });
            }

            var region = await regionSP.ObtenerPorIdAsync(
                idRegion,
                cancellationToken);

            return region is null
                ? Results.NotFound(new
                {
                    mensaje = $"No se encontró la región {idRegion}."
                })
                : Results.Ok(region);
        })
        .WithName("ObtenerRegionPorId")
        .WithSummary("Obtiene una región por su identificador")
        .Produces(StatusCodes.Status200OK)
        .Produces(StatusCodes.Status400BadRequest)
        .Produces(StatusCodes.Status404NotFound);

        return app;
    }
}