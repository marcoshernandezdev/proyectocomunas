using Microsoft.EntityFrameworkCore;
using ProyectoComunas.Datos.Models;

namespace ProyectoComunas.Datos.StoredProcedures;

public sealed class RegionSP
{
    private readonly ApplicationDbContext _context;

    public RegionSP(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<List<Region>> ObtenerTodosAsync(
        CancellationToken cancellationToken = default)
    {
        return await _context.Regiones
            .FromSqlRaw("EXEC dbo.pc_Region_ObtenerTodos")
            .AsNoTracking()
            .ToListAsync(cancellationToken);
    }

    public async Task<Region?> ObtenerPorIdAsync(
        int idRegion,
        CancellationToken cancellationToken = default)
    {
        var regiones = await _context.Regiones
            .FromSqlInterpolated(
                $"EXEC dbo.pc_Region_ObtenerPorId @IdRegion = {idRegion}")
            .AsNoTracking()
            .ToListAsync(cancellationToken);

        return regiones.SingleOrDefault();
    }
}