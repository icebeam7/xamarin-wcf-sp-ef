/* Creación y uso de la base de datos Musica */
CREATE DATABASE Musica
GO

USE Musica
GO

/* Parte 1. Tablas */
CREATE TABLE Artistas(
  Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  Nombre VARCHAR(100) NOT NULL,
  Pais VARCHAR(100) NOT NULL
)

CREATE TABLE Canciones(
  Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  Titulo VARCHAR(200) NOT NULL,
  Duracion VARCHAR(10) NOT NULL
)

CREATE TABLE Conciertos(
  Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  IdArtista INT NOT NULL,
  Lugar VARCHAR(100) NOT NULL,
  Fecha SMALLDATETIME NOT NULL,
  CONSTRAINT FK_Artista FOREIGN KEY (IdArtista) REFERENCES Artistas(Id) ON DELETE CASCADE
)

CREATE TABLE DetallesConcierto(
  IdConcierto INT NOT NULL,
  IdCancion INT NOT NULL,
  Orden INT NOT NULL,
  CONSTRAINT FK_Concierto FOREIGN KEY (IdConcierto) REFERENCES Conciertos(Id) ON DELETE CASCADE,
  CONSTRAINT FK_Cancion FOREIGN KEY (IdCancion) REFERENCES Canciones(Id) ON DELETE CASCADE,
  CONSTRAINT PK_DetalleConcierto PRIMARY KEY (IdConcierto, IdCancion)
)
GO

/* Parte 2. Procedimientos Almacenados */
/* a. Tabla Artistas */
CREATE PROCEDURE Procedimiento_ObtenerArtistas
AS
  SELECT * FROM Artistas ORDER BY Nombre
GO

CREATE PROCEDURE Procedimiento_BuscarArtista (@Id INT)
AS
  SELECT * FROM Artistas WHERE Id = @Id 
GO

CREATE PROCEDURE Procedimiento_AgregarArtista (@Nombre VARCHAR(100), @Pais VARCHAR(100), @mensaje VARCHAR(MAX) OUTPUT)
AS
  SET NOCOUNT ON
  BEGIN TRANSACTION
    INSERT INTO Artistas VALUES (@Nombre, @Pais)
    IF @@error = 0
	  BEGIN
	    SELECT @mensaje = 'Correcto'
	  END
    ELSE
	  BEGIN
	    SELECT @mensaje = 'Error al insertar'
		ROLLBACK TRANSACTION
		RETURN 0
	  END
  COMMIT TRANSACTION
  RETURN SCOPE_IDENTITY()
GO

CREATE PROCEDURE Procedimiento_ModificarArtista (@Id INT, @Nombre VARCHAR(100), @Pais VARCHAR(100), @mensaje VARCHAR(MAX) OUTPUT)
AS
  SET NOCOUNT ON
  BEGIN TRANSACTION
    UPDATE Artistas SET Nombre = @Nombre, Pais = @Pais WHERE Id = @Id
    IF @@ERROR = 0 AND @@ROWCOUNT <> 0
	  BEGIN
	    SELECT @mensaje = 'Correcto'
	  END
    ELSE
	  BEGIN
	    SELECT @mensaje = 'Error al modificar'
		ROLLBACK TRANSACTION
		RETURN 0
	  END
  COMMIT TRANSACTION
  RETURN 1
GO

CREATE PROCEDURE Procedimiento_EliminarArtista (@Id INT, @mensaje VARCHAR(MAX) OUTPUT)
AS
  SET NOCOUNT ON
  BEGIN TRANSACTION
    DELETE FROM Artistas WHERE Id = @Id
    IF @@ERROR = 0
	  BEGIN
	    SELECT @mensaje = 'Registro eliminado correctamente'
	  END
    ELSE
	  BEGIN
	    SELECT @mensaje = 'Error al eliminar'
		ROLLBACK TRANSACTION
		RETURN 0
	  END
  COMMIT TRANSACTION
  RETURN 1
GO

/* b. Tabla Canciones */
CREATE PROCEDURE Procedimiento_ObtenerCanciones
AS
  SELECT * FROM Canciones ORDER BY Titulo
GO

CREATE PROCEDURE Procedimiento_BuscarCancion (@Id INT)
AS
  SELECT * FROM Canciones WHERE Id = @Id 
GO

CREATE PROCEDURE Procedimiento_AgregarCancion (@Titulo VARCHAR(200), @Duracion VARCHAR(10), @mensaje VARCHAR(MAX) OUTPUT)
AS
  SET NOCOUNT ON
  BEGIN TRANSACTION
    INSERT INTO Canciones VALUES (@Titulo, @Duracion)
    IF @@error = 0
	  BEGIN
	    SELECT @mensaje = 'Correcto'
	  END
    ELSE
	  BEGIN
	    SELECT @mensaje = 'Error al insertar'
		ROLLBACK TRANSACTION
		RETURN 0
	  END
  COMMIT TRANSACTION
  RETURN SCOPE_IDENTITY()
GO

CREATE PROCEDURE Procedimiento_ModificarCancion (@Id INT, @Titulo VARCHAR(200), @Duracion VARCHAR(10), @mensaje VARCHAR(MAX) OUTPUT)
AS
  SET NOCOUNT ON
  BEGIN TRANSACTION
    UPDATE Canciones SET Titulo = @Titulo, Duracion = @Duracion WHERE Id = @Id
    IF @@ERROR = 0 AND @@ROWCOUNT <> 0
	  BEGIN
	    SELECT @mensaje = 'Correcto'
	  END
    ELSE
	  BEGIN
	    SELECT @mensaje = 'Error al modificar'
		ROLLBACK TRANSACTION
		RETURN 0
	  END
  COMMIT TRANSACTION
  RETURN 1
GO

CREATE PROCEDURE Procedimiento_EliminarCancion (@Id INT, @mensaje VARCHAR(MAX) OUTPUT)
AS
  SET NOCOUNT ON
  BEGIN TRANSACTION
    DELETE FROM Canciones WHERE Id = @Id
    IF @@ERROR = 0
	  BEGIN
	    SELECT @mensaje = 'Registro eliminado correctamente'
	  END
    ELSE
	  BEGIN
	    SELECT @mensaje = 'Error al eliminar'
		ROLLBACK TRANSACTION
		RETURN 0
	  END
  COMMIT TRANSACTION
  RETURN 1
GO

/* c. Tabla Conciertos */
CREATE PROCEDURE Procedimiento_ObtenerConciertos
AS
  SELECT * FROM Conciertos ORDER BY Fecha 
GO

CREATE PROCEDURE Procedimiento_BuscarConcierto (@Id INT)
AS
  SELECT * FROM Conciertos WHERE Id = @Id 
GO

CREATE PROCEDURE Procedimiento_AgregarConcierto (@IdArtista INT, @Lugar VARCHAR(100), @Fecha SMALLDATETIME, @mensaje VARCHAR(MAX) OUTPUT)
AS
  SET NOCOUNT ON
  BEGIN TRANSACTION
    INSERT INTO Conciertos VALUES (@IdArtista, @Lugar, @Fecha)
    IF @@error = 0
	  BEGIN
	    SELECT @mensaje = 'Correcto'
	  END
    ELSE
	  BEGIN
	    SELECT @mensaje = 'Error al insertar'
		ROLLBACK TRANSACTION
		RETURN 0
	  END
  COMMIT TRANSACTION
  RETURN SCOPE_IDENTITY()
GO

CREATE PROCEDURE Procedimiento_ModificarConcierto (@Id INT, @IdArtista INT, @Lugar VARCHAR(100), @Fecha SMALLDATETIME, @mensaje VARCHAR(MAX) OUTPUT)
AS
  SET NOCOUNT ON
  BEGIN TRANSACTION
    UPDATE Conciertos SET IdArtista = @IdArtista, Lugar = @Lugar, Fecha = @Fecha WHERE Id = @Id
    IF @@ERROR = 0 AND @@ROWCOUNT <> 0
	  BEGIN
	    SELECT @mensaje = 'Correcto'
	  END
    ELSE
	  BEGIN
	    SELECT @mensaje = 'Error al modificar'
		ROLLBACK TRANSACTION
		RETURN 0
	  END
  COMMIT TRANSACTION
  RETURN 1
GO

CREATE PROCEDURE Procedimiento_EliminarConcierto (@Id INT, @mensaje VARCHAR(MAX) OUTPUT)
AS
  SET NOCOUNT ON
  BEGIN TRANSACTION
    DELETE FROM Conciertos WHERE Id = @Id
    IF @@ERROR = 0
	  BEGIN
	    SELECT @mensaje = 'Registro eliminado correctamente'
	  END
    ELSE
	  BEGIN
	    SELECT @mensaje = 'Error al eliminar'
		ROLLBACK TRANSACTION
		RETURN 0
	  END
  COMMIT TRANSACTION
  RETURN 1
GO

/* d. Tabla DetallesConcierto */
CREATE PROCEDURE Procedimiento_ObtenerDetallesConcierto (@IdConcierto INT)
AS
  SELECT * FROM DetallesConcierto WHERE IdConcierto = @IdConcierto ORDER BY Orden
GO

CREATE PROCEDURE Procedimiento_AgregarDetalleConcierto (@IdConcierto INT, @IdCancion INT, @Orden INT, @mensaje VARCHAR(MAX) OUTPUT)
AS
  SET NOCOUNT ON
  BEGIN TRANSACTION
    INSERT INTO DetallesConcierto VALUES (@IdConcierto, @IdCancion, @Orden)
    IF @@error = 0
	  BEGIN
	    SELECT @mensaje = 'Correcto'
	  END
    ELSE
	  BEGIN
	    SELECT @mensaje = 'Error al insertar'
		ROLLBACK TRANSACTION
		RETURN 0
	  END
  COMMIT TRANSACTION
  RETURN 1
GO

CREATE PROCEDURE Procedimiento_ModificarDetalleConcierto (@IdConcierto INT, @IdCancion INT, @Orden INT, @mensaje VARCHAR(MAX) OUTPUT)
AS
  SET NOCOUNT ON
  BEGIN TRANSACTION
    UPDATE DetallesConcierto SET Orden = @Orden WHERE IdConcierto = @IdConcierto AND IdCancion = @IdCancion
    IF @@ERROR = 0 AND @@ROWCOUNT <> 0
	  BEGIN
	    SELECT @mensaje = 'Correcto'
	  END
    ELSE
	  BEGIN
	    SELECT @mensaje = 'Error al modificar'
		ROLLBACK TRANSACTION
		RETURN 0
	  END
  COMMIT TRANSACTION
  RETURN 1
GO

CREATE PROCEDURE Procedimiento_EliminarDetalleConcierto (@IdConcierto INT, @IdCancion INT, @mensaje VARCHAR(MAX) OUTPUT)
AS
  SET NOCOUNT ON
  BEGIN TRANSACTION
    DELETE FROM DetallesConcierto WHERE IdConcierto = @IdConcierto AND IdCancion = @IdCancion
    IF @@ERROR = 0
	  BEGIN
	    SELECT @mensaje = 'Registro eliminado correctamente'
	  END
    ELSE
	  BEGIN
	    SELECT @mensaje = 'Error al eliminar'
		ROLLBACK TRANSACTION
		RETURN 0
	  END
  COMMIT TRANSACTION
  RETURN 1
GO

/* Parte 3. Probar procedimientos almacenados */
/* a. Procedimientos de Tabla Artista */

DECLARE @Id INT
DECLARE @Nombre VARCHAR(100)
DECLARE @Pais VARCHAR(100)
DECLARE @mensaje VARCHAR(MAX) 

SET @Nombre = 'Katie Melua'
SET @Pais = 'Georgia'
EXEC @Id = Procedimiento_AgregarArtista @Nombre, @Pais, @mensaje OUTPUT

SELECT @Id AS ID, @mensaje AS Mensaje
GO

DECLARE @Id INT
DECLARE @Nombre VARCHAR(100)
DECLARE @Pais VARCHAR(100)
DECLARE @mensaje VARCHAR(MAX) 

SET @Nombre = 'The Corrs'
SET @Pais = 'Irlanda'
EXEC @Id = Procedimiento_AgregarArtista @Nombre, @Pais, @mensaje OUTPUT

SELECT @Id AS ID, @mensaje AS Mensaje
GO

EXEC Procedimiento_ObtenerArtistas
GO

DECLARE @Id INT
DECLARE @Nombre VARCHAR(100)
DECLARE @Pais VARCHAR(100)
DECLARE @mensaje VARCHAR(MAX) 
DECLARE @resultado INT

SET @Nombre = 'Katie Melua'
SET @Pais = 'Gran Bretaña'
SET @Id = 1

EXEC @resultado = Procedimiento_ModificarArtista @Id, @Nombre, @Pais, @mensaje OUTPUT

SELECT @resultado AS Resultado, @mensaje AS Mensaje

EXEC Procedimiento_BuscarArtista @Id
GO

DECLARE @Id INT
DECLARE @mensaje VARCHAR(MAX) 
DECLARE @resultado INT

SET @Id = 2

EXEC @resultado = Procedimiento_EliminarArtista @Id, @mensaje OUTPUT

SELECT @resultado AS Resultado, @mensaje AS Mensaje

EXEC Procedimiento_BuscarArtista @Id
GO

DECLARE @mensaje VARCHAR(MAX)
EXEC Procedimiento_AgregarArtista 'The Corrs', 'Irlanda', @mensaje OUTPUT
EXEC Procedimiento_AgregarArtista 'Michael Buble', 'Canada', @mensaje OUTPUT
EXEC Procedimiento_ObtenerArtistas
GO

/* b. Procedimientos de Tabla Canciones */
DECLARE @mensaje VARCHAR(MAX)
EXEC Procedimiento_AgregarCancion 'Better than a dream', '03:16', @mensaje OUTPUT
EXEC Procedimiento_AgregarCancion 'The bit that I don''t get', '03:06', @mensaje OUTPUT
EXEC Procedimiento_AgregarCancion 'What I miss about you', '03:47', @mensaje OUTPUT
EXEC Procedimiento_AgregarCancion 'Nine million bicycles', '03:14', @mensaje OUTPUT
EXEC Procedimiento_AgregarCancion 'I Cried for you', '03:42', @mensaje OUTPUT
EXEC Procedimiento_AgregarCancion 'Only when I sleep', '03:51', @mensaje OUTPUT
EXEC Procedimiento_AgregarCancion 'Somebody for someone', '04:06', @mensaje OUTPUT
EXEC Procedimiento_AgregarCancion 'Radio', '04:15', @mensaje OUTPUT
EXEC Procedimiento_AgregarCancion 'Song for you', '04:06', @mensaje OUTPUT
EXEC Procedimiento_AgregarCancion 'Everything', '03:33', @mensaje OUTPUT
EXEC Procedimiento_ObtenerCanciones
GO

/* c. Procedimientos de Tabla Conciertos */
DECLARE @mensaje VARCHAR(MAX)
EXEC Procedimiento_AgregarConcierto 1, 'Londres', '08-Nov-2008', @mensaje OUTPUT
EXEC Procedimiento_AgregarConcierto 1, 'Utretcht', '01-Nov-2016', @mensaje OUTPUT
EXEC Procedimiento_AgregarConcierto 3, 'Dublín', '12-Nov-1999', @mensaje OUTPUT
EXEC Procedimiento_AgregarConcierto 3, 'Dublín', '06-Nov-2001', @mensaje OUTPUT
EXEC Procedimiento_AgregarConcierto 4, 'Nueva York', '15-Jun-2009', @mensaje OUTPUT
EXEC Procedimiento_ObtenerConciertos
GO

/* d. Procedimientos de Tabla DetallesConcierto */
DECLARE @mensaje VARCHAR(MAX)
EXEC Procedimiento_AgregarDetalleConcierto 1, 4, 16, @mensaje OUTPUT
EXEC Procedimiento_AgregarDetalleConcierto 1, 5, 19, @mensaje OUTPUT
EXEC Procedimiento_AgregarDetalleConcierto 2, 1, 1, @mensaje OUTPUT
EXEC Procedimiento_AgregarDetalleConcierto 2, 2, 2, @mensaje OUTPUT
EXEC Procedimiento_AgregarDetalleConcierto 2, 3, 3, @mensaje OUTPUT
EXEC Procedimiento_AgregarDetalleConcierto 3, 6, 1, @mensaje OUTPUT
EXEC Procedimiento_AgregarDetalleConcierto 3, 8, 3, @mensaje OUTPUT
EXEC Procedimiento_AgregarDetalleConcierto 4, 6, 1, @mensaje OUTPUT
EXEC Procedimiento_AgregarDetalleConcierto 4, 7, 8, @mensaje OUTPUT
EXEC Procedimiento_AgregarDetalleConcierto 5, 9, 10, @mensaje OUTPUT
EXEC Procedimiento_AgregarDetalleConcierto 5, 10, 8, @mensaje OUTPUT
EXEC Procedimiento_ObtenerDetallesConcierto 1
EXEC Procedimiento_ObtenerDetallesConcierto 2
EXEC Procedimiento_ObtenerDetallesConcierto 3
EXEC Procedimiento_ObtenerDetallesConcierto 4
EXEC Procedimiento_ObtenerDetallesConcierto 5
GO




