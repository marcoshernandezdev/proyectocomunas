using Microsoft.EntityFrameworkCore;
using ProyectoComunas.Datos.Models;
using ProyectoComunas.Datos.Configuration;

namespace ProyectoComunas.Datos.StoredProcedures;

public sealed class RegionSP
{
    private readonly ApplicationDbContext _context;
    private readonly StoredProcedureNames _spNames;

    public RegionSP(ApplicationDbContext context, StoredProcedureNames spNames)
    {
        _context = context;
        _spNames = spNames;
    }

    public async Task<List<Region>> ObtenerTodosAsync(
        CancellationToken cancellationToken = default)
    {
        // Nombre del SP proveniente de configuración controlada
        var sp = $"dbo.{_spNames.RegionObtenerTodos}";
        return await _context.Regiones
            .FromSqlRaw($"EXEC {sp}")
            .AsNoTracking()
            .ToListAsync(cancellationToken);
    }

    public async Task<Region?> ObtenerPorIdAsync(
        int idRegion,
        CancellationToken cancellationToken = default)
    {
        var sp = $"dbo.{_spNames.RegionObtenerPorId}";
        var regiones = await _context.Regiones
            .FromSqlInterpolated($"EXEC {sp} @IdRegion = {idRegion}")
            .AsNoTracking()
            .ToListAsync(cancellationToken);

        return regiones.SingleOrDefault();
    }
}