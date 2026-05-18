--CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE FundamicroDB;
GO

USE FundamicroDB;
GO

--TABLA DE USUARIOS
CREATE TABLE Usuarios (
    UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    NombreCompleto VARCHAR(100) NOT NULL,
    Activo BIT DEFAULT 1 NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE() NOT NULL
);
GO

--TABLA DE CLIENTES
CREATE TABLE Clientes (
    ClienteID INT IDENTITY(1,1) PRIMARY KEY,
    Nombres VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    DocumentoIdentidad VARCHAR(20) NOT NULL UNIQUE,
    Email VARCHAR(100) NULL,
    Telefono VARCHAR(20) NULL,
    FechaRegistro DATETIME DEFAULT GETDATE() NOT NULL
);
GO

--TABLA DE BITÁCORA
CREATE TABLE Bitacora (
    BitacoraID INT IDENTITY(1,1) PRIMARY KEY,
    Accion VARCHAR(20) NOT NULL, -- 'AGREGAR', 'EDITAR', 'ELIMINAR'
    ClienteID INT NOT NULL,
    DetalleCambio NVARCHAR(MAX) NOT NULL,
    Username VARCHAR(50) NOT NULL,
    FechaHora DATETIME DEFAULT GETDATE() NOT NULL
);
GO

--Índices para optimizar la auditoría en la Bitácora
CREATE NONCLUSTERED INDEX IX_Bitacora_ClienteID ON Bitacora(ClienteID);
CREATE NONCLUSTERED INDEX IX_Bitacora_FechaHora ON Bitacora(FechaHora);
GO

--PROCEDIMIENTOS ALMACENADOS (Abstracción de Datos)

--Validar Credenciales de Usuario
CREATE PROCEDURE sp_Usuarios_ValidarCredenciales
    @Username VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT UsuarioID, Username, PasswordHash, NombreCompleto 
    FROM Usuarios 
    WHERE Username = @Username AND Activo = 1;
END;
GO

--Gestionar Clientes (CRUD + Bitácora en una sola Transacción para consistencia)
CREATE PROCEDURE sp_Clientes_Guardar
    @ClienteID INT,
    @Nombres VARCHAR(100),
    @Apellidos VARCHAR(100),
    @DocumentoIdentidad VARCHAR(20),
    @Email VARCHAR(100),
    @Telefono VARCHAR(20),
    @Username VARCHAR(50),
    @Accion VARCHAR(20) -- 'AGREGAR' o 'EDITAR'
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        IF @Accion = 'AGREGAR'
        BEGIN
            INSERT INTO Clientes (Nombres, Apellidos, DocumentoIdentidad, Email, Telefono)
            VALUES (@Nombres, @Apellidos, @DocumentoIdentidad, @Email, @Telefono);

            SET @ClienteID = SCOPE_IDENTITY();

            INSERT INTO Bitacora (Accion, ClienteID, DetalleCambio, Username)
            VALUES ('AGREGAR', @ClienteID, CONCAT('Cliente creado: ', @Nombres, ' ', @Apellidos), @Username);
        END
        ELSE IF @Accion = 'EDITAR'
        BEGIN
            INSERT INTO Bitacora (Accion, ClienteID, DetalleCambio, Username)
            VALUES ('EDITAR', @ClienteID, CONCAT('Modificación de datos del cliente ID: ', @ClienteID), @Username);

            UPDATE Clientes
            SET Nombres = @Nombres,
                Apellidos = @Apellidos,
                DocumentoIdentidad = @DocumentoIdentidad,
                Email = @Email,
                Telefono = @Telefono
            WHERE ClienteID = @ClienteID;
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

CREATE PROCEDURE sp_Clientes_Eliminar
    @ClienteID INT,
    @Username VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Bitacora (Accion, ClienteID, DetalleCambio, Username)
        VALUES ('ELIMINAR', @ClienteID, 'Cliente eliminado del sistema', @Username);

        DELETE FROM Clientes WHERE ClienteID = @ClienteID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

--INSERCIÓN DE USUARIO DE PRUEBA
--Password: "1234"
INSERT INTO Usuarios (Username, PasswordHash, NombreCompleto)
VALUES ('admin', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'Administrador Sistema');
GO