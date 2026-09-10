using System.ComponentModel.DataAnnotations;

namespace ProyectoComunas.Datos.Models;

public sealed class Region
{
    [Key]
    public int IdRegion { get; set; }

    [StringLength(128)]
    public string? NombreRegion { get; set; }
}
