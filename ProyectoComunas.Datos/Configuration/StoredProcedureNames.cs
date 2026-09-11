using System;
using System.Text.RegularExpressions;

namespace ProyectoComunas.Datos.Configuration;

public sealed class StoredProcedureNames
{
    public string RegionObtenerTodos { get; set; } = string.Empty;

    public string RegionObtenerPorId { get; set; } = string.Empty;

    public string ComunaObtenerPorRegion { get; set; } = string.Empty;

    public string ComunaObtenerPorId { get; set; } = string.Empty;

    public string ComunaGuardar { get; set; } = string.Empty;

    public void Validate()
    {
        var regex = new Regex(@"^[A-Za-z0-9_]+$", RegexOptions.Compiled);

        var values = new (string Name, string Value)[]
        {
            (nameof(RegionObtenerTodos), RegionObtenerTodos),
            (nameof(RegionObtenerPorId), RegionObtenerPorId),
            (nameof(ComunaObtenerPorRegion), ComunaObtenerPorRegion),
            (nameof(ComunaObtenerPorId), ComunaObtenerPorId),
            (nameof(ComunaGuardar), ComunaGuardar)
        };

        foreach (var (name, value) in values)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                throw new InvalidOperationException($"El nombre del procedimiento almacenado '{name}' no puede estar vacío.");
            }

            if (!regex.IsMatch(value))
            {
                throw new InvalidOperationException($"El nombre del procedimiento almacenado '{name}' contiene caracteres no permitidos.");
            }
        }
    }
}
