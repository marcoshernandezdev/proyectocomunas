USE ProyectoComunas;
GO
CREATE OR ALTER PROCEDURE dbo.pc_Comuna_ObtenerPorRegion
    @IdRegion INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        IdComuna,
        IdRegion,
        NombreComuna,
        InformacionAdicional
    FROM dbo.Comuna
    WHERE IdRegion = @IdRegion
    ORDER BY NombreComuna;
END;
GO