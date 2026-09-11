using ProyectoComunas.Datos.Configuration;
using System;
using Xunit;

namespace ProyectoComunas.Tests;

public class StoredProcedureNamesTests
{
    [Fact]
    public void Validate_ValidNames_DoesNotThrow()
    {
        var names = new StoredProcedureNames
        {
            RegionObtenerTodos = "pc_Region_ObtenerTodos",
            RegionObtenerPorId = "pc_Region_ObtenerPorId",
            ComunaObtenerPorRegion = "pc_Comuna_ObtenerPorRegion",
            ComunaObtenerPorId = "pc_Comuna_ObtenerPorId",
            ComunaGuardar = "pc_Comuna_Guardar"
        };

        var ex = Record.Exception(() => names.Validate());
        Assert.Null(ex);
    }

    [Theory]
    [InlineData("")]
    [InlineData("DROP TABLE;")]
    [InlineData("pc-Region*")]
    public void Validate_InvalidNames_Throws(string badName)
    {
        var names = new StoredProcedureNames
        {
            RegionObtenerTodos = badName,
            RegionObtenerPorId = "pc_Region_ObtenerPorId",
            ComunaObtenerPorRegion = "pc_Comuna_ObtenerPorRegion",
            ComunaObtenerPorId = "pc_Comuna_ObtenerPorId",
            ComunaGuardar = "pc_Comuna_Guardar"
        };

        Assert.Throws<InvalidOperationException>(() => names.Validate());
    }
}