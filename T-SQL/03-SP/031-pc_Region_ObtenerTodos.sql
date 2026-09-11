USE ProyectoComunas;
GO
CREATE OR ALTER PROCEDURE dbo.pc_Region_ObtenerTodos
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        IdRegion,
        NombreRegion
    FROM dbo.Region
    ORDER BY NombreRegion;
END;
GO