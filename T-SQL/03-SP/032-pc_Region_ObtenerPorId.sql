USE ProyectoComunas;
GO
CREATE OR ALTER PROCEDURE dbo.pc_Region_ObtenerPorId
    @IdRegion INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        IdRegion,
        NombreRegion
    FROM dbo.Region
    WHERE IdRegion = @IdRegion;
END;
GO