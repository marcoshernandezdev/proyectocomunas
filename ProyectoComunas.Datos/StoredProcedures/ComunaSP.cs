using Microsoft.EntityFrameworkCore;
using ProyectoComunas.Datos.Models;
using ProyectoComunas.Datos.Configuration;

namespace ProyectoComunas.Datos.StoredProcedures;

public sealed class ComunaSP
{
    private readonly ApplicationDbContext _context;
    private readonly StoredProcedureNames _spNames;

    public ComunaSP(ApplicationDbContext context, StoredProcedureNames spNames)
    {
        _context = context;
        _spNames = spNames;
    }

    public async Task<List<Comuna>> ObtenerPorRegionAsync(
        int? idRegion,
        CancellationToken cancellationToken = default)
    {
        var sp = $"dbo.{_spNames.ComunaObtenerPorRegion}";
        return await _context.Comunas
            .FromSqlInterpolated($"EXEC {sp} @IdRegion = {idRegion}")
            .AsNoTracking()
            .ToListAsync(cancellationToken);
    }

    // Firma corregida: ahora recibe idRegion y idComuna
    public async Task<Comuna?> ObtenerPorIdAsync(
        int idRegion,
        int idComuna,
        CancellationToken cancellationToken = default)
    {
        var sp = $"dbo.{_spNames.ComunaObtenerPorId}";
        var comunas = await _context.Comunas
            .FromSqlInterpolated(
                $"EXEC {sp} @IdRegion = {idRegion}, @IdComuna = {idComuna}")
            .AsNoTracking()
            .ToListAsync(cancellationToken);

        return comunas.SingleOrDefault();
    }

    public async Task<int> GuardarAsync(
        int? idRegion,
        Comuna comuna,
        CancellationToken cancellationToken = default)
    {
        var sp = $"dbo.{_spNames.ComunaGuardar}";
        // Ejecuta el SP con parámetros parametrizados correctamente.
        return await _context.Database.ExecuteSqlInterpolatedAsync(
            $"""
            EXEC {sp}
                @IdRegion = {idRegion},
                @IdComuna = {comuna.IdComuna},
                @NombreComuna = {comuna.NombreComuna},
                @InformacionAdicional = {comuna.InformacionAdicional}
            """,
            cancellationToken);
    }
}