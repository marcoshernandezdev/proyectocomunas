using ProyectoComunas.Datos.Models;
using ProyectoComunas.Datos.StoredProcedures;

namespace ProyectoComunas.API.Endpoints;

public static class ComunaEndpoints
{
    public static IEndpointRouteBuilder MapComunaEndpoints(
        this IEndpointRouteBuilder app)
    {
        var group = app
            .MapGroup("/api/regiones/{idRegion:int}/comunas")
            .WithTags("Comunas");

        group.MapGet("/", async (
            int idRegion,
            ComunaSP comunaSP,
            CancellationToken cancellationToken) =>
        {
            if (idRegion <= 0)
            {
                return Results.BadRequest(new
                {
                    mensaje = "El identificador de la región debe ser mayor que cero."
                });
            }

            var comunas = await comunaSP.ObtenerPorRegionAsync(
                idRegion,
                cancellationToken);

            return Results.Ok(comunas);
        })
        .WithName("ObtenerComunasPorRegion")
        .WithSummary("Obtiene las comunas pertenecientes a una región")
        .Produces(StatusCodes.Status200OK)
        .Produces(StatusCodes.Status400BadRequest);

        group.MapGet("/{idComuna:int}", async (
            int idRegion,
            int idComuna,
            ComunaSP comunaSP,
            CancellationToken cancellationToken) =>
        {
            if (idRegion <= 0 || idComuna <= 0)
            {
                return Results.BadRequest(new
                {
                    mensaje = "Los identificadores deben ser mayores que cero."
                });
            }

            var comuna = await comunaSP.ObtenerPorIdAsync(
                idComuna,
                cancellationToken);

            if (comuna is null || comuna.IdRegion != idRegion)
            {
                return Results.NotFound(new
                {
                    mensaje = $"No se encontró la comuna {idComuna} " +
                              $"en la región {idRegion}."
                });
            }

            return Results.Ok(comuna);
        })
        .WithName("ObtenerComunaPorId")
        .WithSummary("Obtiene una comuna por su identificador")
        .Produces(StatusCodes.Status200OK)
        .Produces(StatusCodes.Status400BadRequest)
        .Produces(StatusCodes.Status404NotFound);

        group.MapPut("/{idComuna:int}", async (
            int idRegion,
            int idComuna,
            Comuna comuna,
            ComunaSP comunaSP,
            CancellationToken cancellationToken) =>
        {
            if (idRegion <= 0 || idComuna <= 0)
            {
                return Results.BadRequest(new
                {
                    mensaje = "Los identificadores deben ser mayores que cero."
                });
            }

            if (comuna.IdComuna != 0 && comuna.IdComuna != idComuna)
            {
                return Results.BadRequest(new
                {
                    mensaje = "El IdComuna del cuerpo no coincide con la URL."
                });
            }

            if (comuna.IdRegion.HasValue &&
                comuna.IdRegion.Value != idRegion)
            {
                return Results.BadRequest(new
                {
                    mensaje = "El IdRegion del cuerpo no coincide con la URL."
                });
            }

            comuna.IdComuna = idComuna;
            comuna.IdRegion = idRegion;

            await comunaSP.GuardarAsync(
                idRegion,
                comuna,
                cancellationToken);

            var comunaActualizada = await comunaSP.ObtenerPorIdAsync(
                idComuna,
                cancellationToken);

            return comunaActualizada is null
                ? Results.NotFound(new
                {
                    mensaje = "La comuna fue procesada, pero no pudo recuperarse."
                })
                : Results.Ok(comunaActualizada);
        })
        .WithName("GuardarComuna")
        .WithSummary("Actualiza una comuna mediante el procedimiento con MERGE")
        .Produces(StatusCodes.Status200OK)
        .Produces(StatusCodes.Status400BadRequest)
        .Produces(StatusCodes.Status404NotFound);

        return app;
    }
}