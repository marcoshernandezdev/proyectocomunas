using Microsoft.EntityFrameworkCore;
using ProyectoComunas.Datos.Models;

namespace ProyectoComunas.Datos.StoredProcedures;

public sealed class ComunaSP
{
    private readonly ApplicationDbContext _context;

    public ComunaSP(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<List<Comuna>> ObtenerPorRegionAsync(
        int? idRegion,
        CancellationToken cancellationToken = default)
    {
        return await _context.Comunas
            .FromSqlInterpolated(
                $"EXEC dbo.pc_Comuna_ObtenerPorRegion @IdRegion = {idRegion}")
            .AsNoTracking()
            .ToListAsync(cancellationToken);
    }

    public async Task<Comuna?> ObtenerPorIdAsync(
        int idComuna,
        CancellationToken cancellationToken = default)
    {
        var comunas = await _context.Comunas
            .FromSqlInterpolated(
                $"EXEC dbo.pc_Comuna_ObtenerPorId @IdComuna = {idComuna}")
            .AsNoTracking()
            .ToListAsync(cancellationToken);

        return comunas.SingleOrDefault();
    }

    public async Task<int> GuardarAsync(
        int? idRegion,
        Comuna comuna,
        CancellationToken cancellationToken = default)
    {
        return await _context.Database.ExecuteSqlInterpolatedAsync(
            $"""
            EXEC dbo.pc_Comuna_Guardar
                @IdRegion = {idRegion},
                @IdComuna = {comuna.IdComuna},
                @NombreComuna = {comuna.NombreComuna},
                @InformacionAdicional = {comuna.InformacionAdicional}
            """,
            cancellationToken);
    }
}