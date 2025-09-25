-- Crear la base de datos MELODB
CREATE DATABASE MELODB;
USE MELODB;
-- Crear la base de datos MELODB




-- Crear tabla FECHA
CREATE TABLE FECHA (
    id_fecha INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    día_semana VARCHAR(20),
    mes INT,
    año INT,
    Workday_weekend BOOLEAN,
    estación VARCHAR(20),
    trimester INT
);

-- Crear tabla CIUDAD
CREATE TABLE CIUDAD (
    id_ciudad INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    código VARCHAR(10) NOT NULL  -- Código del país (ej. ES, UK, FR, US)
);

-- Crear tabla ARTISTAS
CREATE TABLE ARTISTAS (
    artista_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    id_ciudad INT,
    FOREIGN KEY (id_ciudad) REFERENCES CIUDAD(id_ciudad)  -- Relación con CIUDAD
);

-- Crear tabla CANCIONES
CREATE TABLE CANCIONES (
    cancion_id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    duracion INT,
    id_fecha INT NOT NULL,
    artista_id INT NOT NULL,
    FOREIGN KEY (id_fecha) REFERENCES FECHA(id_fecha),
    FOREIGN KEY (artista_id) REFERENCES ARTISTAS(artista_id)
);

-- Crear tabla USUARIOS
CREATE TABLE USUARIOS (
    usuario_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    correo_electronico VARCHAR(255) NOT NULL,
    id_fecha_registro INT,
    id_ciudad INT,
    FOREIGN KEY (id_fecha_registro) REFERENCES FECHA(id_fecha),
    FOREIGN KEY (id_ciudad) REFERENCES CIUDAD(id_ciudad)
);

-- Crear tabla FAVORITOS
CREATE TABLE FAVORITOS (
    id_favorito INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_cancion INT NOT NULL,
    id_fecha INT,
    FOREIGN KEY (id_usuario) REFERENCES USUARIOS(usuario_id),
    FOREIGN KEY (id_cancion) REFERENCES CANCIONES(cancion_id),
    FOREIGN KEY (id_fecha) REFERENCES FECHA(id_fecha)
);

-- Crear tabla EVENTOS_EN_VIVO
CREATE TABLE EVENTOS_EN_VIVO (
    id_evento INT PRIMARY KEY AUTO_INCREMENT,
    id_artista INT NOT NULL,
    nombre_evento VARCHAR(255) NOT NULL,
    fecha INT NOT NULL,
    id_ciudad INT NOT NULL,
    duracion_min INT,
    descripcion TEXT,
    FOREIGN KEY (id_artista) REFERENCES ARTISTAS(artista_id),
    FOREIGN KEY (id_ciudad) REFERENCES CIUDAD(id_ciudad),
	FOREIGN KEY (fecha) REFERENCES FECHA(id_fecha)
);

-- Crear tabla REPRODUCCIONES
CREATE TABLE REPRODUCCIONES (
    id_reproduccion INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_cancion INT NOT NULL,
    fecha_reproduccion INT NOT NULL,  -- Cambiado a INT para ser FK
    duracion_reproducida INT NOT NULL,
    dispositivo VARCHAR(50),
    id_ciudad INT,  -- Opcional
    FOREIGN KEY (id_usuario) REFERENCES USUARIOS(usuario_id),
    FOREIGN KEY (id_cancion) REFERENCES CANCIONES(cancion_id),
    FOREIGN KEY (fecha_reproduccion) REFERENCES FECHA(id_fecha),  -- FK a la tabla FECHA
    FOREIGN KEY (id_ciudad) REFERENCES CIUDAD(id_ciudad)  -- Suponiendo que hay una tabla UBICACION
);


