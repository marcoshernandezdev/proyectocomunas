using System.ComponentModel.DataAnnotations;

namespace ProyectoComunas.Datos.Models;

public sealed class Comuna
{
    [Key]
    public int IdComuna { get; set; }

    public int? IdRegion { get; set; }
        
    [StringLength(128)]
    public string? NombreComuna { get; set; }

    public string? InformacionAdicional { get; set; }
}
