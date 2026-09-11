namespace ProyectoComunas.Datos.Configuration;

public sealed class StoredProcedureNames
{
    public string RegionObtenerTodos { get; set; } = string.Empty;

    public string RegionObtenerPorId { get; set; } = string.Empty;

    public string ComunaObtenerPorRegion { get; set; } = string.Empty;

    public string ComunaObtenerPorId { get; set; } = string.Empty;

    public string ComunaGuardar { get; set; } = string.Empty;
}
