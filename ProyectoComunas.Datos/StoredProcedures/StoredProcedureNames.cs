using System.Text.RegularExpressions;

namespace ProyectoComunas.Datos.StoredProcedures;

public sealed class StoredProcedureNames
{
    private static readonly Regex ValidName =
        new(@"^[A-Za-z][A-Za-z0-9_]*$", RegexOptions.Compiled);

    public string RegionObtenerTodos { get; init; } = "pcRegion_ObtenerTodos";
    public string RegionObtenerPorId { get; init; } = "pcRegion_ObtenerPorId";
    public string ComunaObtenerPorRegion { get; init; } = "pcComuna_ObtenerPorRegion";
    public string ComunaObtenerPorId { get; init; } = "pcComuna_ObtenerPorId";
    public string ComunaGuardar { get; init; } = "pcComuna_Guardar";

    public void Validate()
    {
        foreach (var name in new[]
        {
            RegionObtenerTodos, RegionObtenerPorId, ComunaObtenerPorRegion,
            ComunaObtenerPorId, ComunaGuardar
        })
        {
            if (!ValidName.IsMatch(name))
                throw new InvalidOperationException($"Nombre de SP no válido: {name}");
        }
    }
}
