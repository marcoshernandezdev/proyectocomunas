USE ProyectoComunas;
GO
CREATE OR ALTER PROCEDURE dbo.pc_Comuna_ObtenerPorId
    @IdRegion INT,
    @IdComuna INT
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
      AND IdComuna = @IdComuna;
END;
GO