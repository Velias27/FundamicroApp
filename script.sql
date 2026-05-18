-- =======================================================
-- CREACIÓN DE LA BASE DE DATOS
-- =======================================================
CREATE DATABASE FundamicroDB;
GO

USE FundamicroDB;
GO

-- =======================================================
-- CREACIÓN DE TABLAS
-- =======================================================

-- TABLA DE USUARIOS
CREATE TABLE Usuarios (
    UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    NombreCompleto VARCHAR(100) NOT NULL,
    Activo BIT DEFAULT 1 NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE() NOT NULL
);
GO

-- TABLA DE CLIENTES (Preparada para Soft Delete)
CREATE TABLE Clientes (
    ClienteID INT IDENTITY(1,1) PRIMARY KEY,
    Nombres VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    DocumentoIdentidad VARCHAR(20) NOT NULL UNIQUE,
    Email VARCHAR(100) NULL,
    Telefono VARCHAR(20) NULL,
    Activo BIT DEFAULT 1 NOT NULL,
    FechaRegistro DATETIME DEFAULT GETDATE() NOT NULL
);
GO

-- TABLA DE BITÁCORA
CREATE TABLE Bitacora (
    BitacoraID INT IDENTITY(1,1) PRIMARY KEY,
    Accion VARCHAR(20) NOT NULL, -- 'AGREGAR', 'EDITAR', 'ELIMINAR'
    ClienteID INT NOT NULL,
    DetalleCambio NVARCHAR(MAX) NOT NULL,
    Username VARCHAR(50) NOT NULL,
    FechaHora DATETIME DEFAULT GETDATE() NOT NULL
);
GO

-- Índices para optimizar el rendimiento de la auditoría
CREATE NONCLUSTERED INDEX IX_Bitacora_ClienteID ON Bitacora(ClienteID);
CREATE NONCLUSTERED INDEX IX_Bitacora_FechaHora ON Bitacora(FechaHora);
GO

-- =======================================================
-- PROCEDIMIENTOS ALMACENADOS
-- =======================================================

-- 1. Validar Credenciales de Usuario
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

-- 2. Gestionar Clientes (Maneja Insert, Update y Auditoría a Nivel de Campo)
CREATE PROCEDURE sp_Clientes_Guardar
    @ClienteID INT,
    @Nombres VARCHAR(100),
    @Apellidos VARCHAR(100),
    @DocumentoIdentidad VARCHAR(20),
    @Email VARCHAR(100),
    @Telefono VARCHAR(20),
    @Username VARCHAR(50),
    @Accion VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @Detalle NVARCHAR(MAX);

        IF @Accion = 'AGREGAR'
        BEGIN
            INSERT INTO Clientes (Nombres, Apellidos, DocumentoIdentidad, Email, Telefono, Activo)
            VALUES (@Nombres, @Apellidos, @DocumentoIdentidad, @Email, @Telefono, 1);

            SET @ClienteID = SCOPE_IDENTITY();
            SET @Detalle = 'Cliente creado: ' + @Nombres + ' ' + @Apellidos;
        END
        ELSE IF @Accion = 'EDITAR'
        BEGIN
            -- 1. Capturamos los datos antiguos ANTES del UPDATE
            DECLARE @OldNombres VARCHAR(100), @OldApellidos VARCHAR(100), 
                    @OldDoc VARCHAR(20), @OldEmail VARCHAR(100), @OldTelefono VARCHAR(20);

            SELECT @OldNombres = Nombres, @OldApellidos = Apellidos, 
                   @OldDoc = DocumentoIdentidad, @OldEmail = Email, @OldTelefono = Telefono
            FROM Clientes 
            WHERE ClienteID = @ClienteID;

            -- 2. Comparamos cada campo y concatenamos si hay diferencias
            DECLARE @Cambios NVARCHAR(MAX) = '';

            IF @OldNombres <> @Nombres 
                SET @Cambios += 'Nombres [' + @OldNombres + ' -> ' + @Nombres + '], ';
            
            IF @OldApellidos <> @Apellidos 
                SET @Cambios += 'Apellidos [' + @OldApellidos + ' -> ' + @Apellidos + '], ';
            
            IF @OldDoc <> @DocumentoIdentidad 
                SET @Cambios += 'DUI [' + @OldDoc + ' -> ' + @DocumentoIdentidad + '], ';
            
            -- Manejo seguro de nulos para campos opcionales
            IF ISNULL(@OldEmail, '') <> ISNULL(@Email, '') 
                SET @Cambios += 'Email [' + ISNULL(@OldEmail, 'Vacío') + ' -> ' + ISNULL(@Email, 'Vacío') + '], ';
            
            IF ISNULL(@OldTelefono, '') <> ISNULL(@Telefono, '') 
                SET @Cambios += 'Tel [' + ISNULL(@OldTelefono, 'Vacío') + ' -> ' + ISNULL(@Telefono, 'Vacío') + '], ';

            -- 3. Hacemos el UPDATE real
            UPDATE Clientes
            SET Nombres = @Nombres,
                Apellidos = @Apellidos,
                DocumentoIdentidad = @DocumentoIdentidad,
                Email = @Email,
                Telefono = @Telefono
            WHERE ClienteID = @ClienteID;

            -- 4. Damos formato al mensaje final
            IF LEN(@Cambios) > 0
            BEGIN
                SET @Cambios = LEFT(@Cambios, LEN(@Cambios) - 1);
                SET @Detalle = 'Cambios en ' + @OldNombres + ': ' + @Cambios;
            END
            ELSE
            BEGIN
                SET @Detalle = 'Se guardó sin realizar cambios reales en ' + @Nombres;
            END
        END

        -- Guardamos en la bitácora
        INSERT INTO Bitacora (Accion, ClienteID, DetalleCambio, Username)
        VALUES (@Accion, @ClienteID, @Detalle, @Username);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- 3. Eliminar Cliente
CREATE PROCEDURE sp_Clientes_Eliminar
    @ClienteID INT,
    @Username VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Extraemos el nombre antes de aplicar el soft delete
        DECLARE @NombreCompleto VARCHAR(200);
        SELECT @NombreCompleto = Nombres + ' ' + Apellidos 
        FROM Clientes 
        WHERE ClienteID = @ClienteID;

        DECLARE @Detalle VARCHAR(255) = 'Borrado del cliente: ' + ISNULL(@NombreCompleto, 'Desconocido');

        UPDATE Clientes 
        SET Activo = 0 
        WHERE ClienteID = @ClienteID;

        INSERT INTO Bitacora (Accion, ClienteID, DetalleCambio, Username)
        VALUES ('ELIMINAR', @ClienteID, @Detalle, @Username);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- =======================================================
-- INSERCIÓN DE DATOS DE PRUEBA (USUARIOS)
-- =======================================================

-- 1. Usuario admin (Password: "1234")
INSERT INTO Usuarios (Username, PasswordHash, NombreCompleto)
VALUES ('admin', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'Administrador Sistema');

-- 2. Usuario fundamicro (Password: "12345")
INSERT INTO Usuarios (Username, PasswordHash, NombreCompleto)
VALUES ('fundamicro', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 'Evaluador Fundamicro');
GO