using System.ComponentModel.DataAnnotations;

namespace ProyectoComunas.Web.Models;

public sealed class Comuna
{
    public int IdComuna { get; set; }
    public int IdRegion { get; set; }

    [Required(ErrorMessage = "El nombre es obligatorio.")]
    [StringLength(128)]
    [Display(Name = "Comuna")]
    public string NombreComuna { get; set; } = string.Empty;

    [Display(Name = "Información adicional XML")]
    public string? InformacionAdicional { get; set; }
}
