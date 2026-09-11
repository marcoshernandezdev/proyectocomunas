USE ProyectoComunas;
GO

CREATE OR ALTER PROCEDURE dbo.pc_Comuna_Guardar
    @IdRegion             INT,
    @IdComuna             INT = NULL,
    @NombreComuna         NVARCHAR(128),
    @InformacionAdicional XML = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF NOT EXISTS(SELECT 8 FROM dbo.Region
        WHERE IdRegion = @IdRegion
    )
    BEGIN
        THROW 50001, 'La región indicada no existe.', 1;
    END;

    set @NombreComuna = LTRIM(RTRIM(@NombreComuna));

    IF NULLIF(@NombreComuna, N'') IS NULL
    BEGIN
        THROW 50002, 'El nombre de la comuna es obligatorio.', 1;
    END;

    DECLARE @Resultado TABLE
    (
        Accion    NVARCHAR(10),
        IdComuna  INT
    );

    MERGE dbo.Comuna WITH (HOLDLOCK) AS Destino
    USING
    (
        SELECT
            @IdComuna AS IdComuna,
            @IdRegion AS IdRegion,
            @NombreComuna AS NombreComuna,
            @InformacionAdicional AS InformacionAdicional
    ) AS Origen
       ON Destino.IdComuna = Origen.IdComuna
      AND Destino.IdRegion = Origen.IdRegion

    WHEN MATCHED THEN
        UPDATE SET
            NombreComuna = Origen.NombreComuna,
            InformacionAdicional = Origen.InformacionAdicional

    WHEN NOT MATCHED THEN
        INSERT
        (
            IdRegion,
            NombreComuna,
            InformacionAdicional
        )
        VALUES
        (
            Origen.IdRegion,
            Origen.NombreComuna,
            Origen.InformacionAdicional
        )

    OUTPUT
        $action,
        inserted.IdComuna
    INTO @Resultado (Accion, IdComuna);

    SELECT Accion, IdComuna
    FROM @Resultado;
END;
GO