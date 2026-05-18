# Prueba Técnica: Sistema de Gestión de Clientes (FUNDAMICRO)

Aplicación web desarrollada en **ASP.NET (VB.NET - Web Forms)** para la gestión y auditoría de clientes, aplicando arquitectura en capas y buenas prácticas de seguridad.

## Características
* **Seguridad:** Autenticación por formularios y contraseñas protegidas mediante Hashing criptográfico (SHA-256).
* **Protección de Datos:** Prevención de SQL Injection (ADO.NET con Parameters) y XSS (HtmlDecode en vistas).
* **Abstracción:** Uso extensivo de Procedimientos Almacenados en SQL Server con control de Transacciones (TRY/CATCH/ROLLBACK) para garantizar integridad ACID.
* **Interfaz:** Diseño responsivo, limpio e intuitivo utilizando Bootstrap 5 y modales.
* **Auditoría:** Módulo de bitácora transaccional para rastrear modificaciones al directorio de clientes.

## Instrucciones para Ejecución Local
1. Clonar este repositorio.
2. Abrir **SQL Server Management Studio**. Ejecutar el script `script.sql` adjunto en la raíz para generar la base de datos, tablas y SPs.
3. Abrir la solución en **Visual Studio**.
4. Modificar el archivo `Web.config` para ajustar el `Data Source` en la cadena de conexión según su servidor SQL local.
5. Compilar la solución e iniciar.

**Credenciales de prueba por defecto:**
* **Usuario:** `admin`
* **Contraseña:** `1234`


* **Usuario:** `fundamicro`
* **Contraseña:** `12345`
