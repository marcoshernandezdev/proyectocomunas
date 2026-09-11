USE master;
GO

IF DB_ID(N'ProyectoComunas') IS NULL
BEGIN
    CREATE DATABASE ProyectoComunas;
END;
GO