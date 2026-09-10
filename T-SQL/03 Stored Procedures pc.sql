USE ProyectoComunas;
GO

CREATE OR ALTER PROCEDURE dbo.pcRegion_ObtenerTodos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdRegion, NombreRegion
    FROM dbo.Region
    ORDER BY NombreRegion;
END;
GO

CREATE OR ALTER PROCEDURE dbo.pcRegion_ObtenerPorId
    @IdRegion INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdRegion, NombreRegion
    FROM dbo.Region
    WHERE IdRegion = @IdRegion;
END;
GO

CREATE OR ALTER PROCEDURE dbo.pcComuna_ObtenerPorRegion
    @IdRegion INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdComuna, IdRegion, NombreComuna, InformacionAdicional
    FROM dbo.Comuna
    WHERE IdRegion = @IdRegion
    ORDER BY NombreComuna;
END;
GO

CREATE OR ALTER PROCEDURE dbo.pcComuna_ObtenerPorId
    @IdRegion INT,
    @IdComuna INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdComuna, IdRegion, NombreComuna, InformacionAdicional
    FROM dbo.Comuna
    WHERE IdRegion = @IdRegion
      AND IdComuna = @IdComuna;
END;
GO

CREATE OR ALTER PROCEDURE dbo.pcComuna_Guardar
    @IdRegion INT,
    @IdComuna INT,
    @NombreComuna NVARCHAR(128),
    @InformacionAdicional XML = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF NOT EXISTS (SELECT 1 FROM dbo.Region WHERE IdRegion = @IdRegion)
        THROW 51010, 'La región indicada no existe.', 1;

    MERGE dbo.Comuna WITH (HOLDLOCK) AS Destino
    USING
    (
        SELECT
            @IdComuna AS IdComuna,
            @IdRegion AS IdRegion,
            LTRIM(RTRIM(@NombreComuna)) AS NombreComuna,
            @InformacionAdicional AS InformacionAdicional
    ) AS Origen
       ON Destino.IdComuna = Origen.IdComuna
      AND Destino.IdRegion = Origen.IdRegion
    WHEN MATCHED THEN
        UPDATE SET
            NombreComuna = Origen.NombreComuna,
            InformacionAdicional = Origen.InformacionAdicional
    WHEN NOT MATCHED THEN
        INSERT (IdRegion, NombreComuna, InformacionAdicional)
        VALUES (Origen.IdRegion, Origen.NombreComuna, Origen.InformacionAdicional);
END;
GO
