-- =========================================================

-- POBLADO DE DATOS DE EJEMPLO PARA MELODB

-- (Incluye tablas extra: GENERO y CANCION_GENERO)

-- =========================================================
 
-- -----------------------------------------

-- 1) FECHA (usar IDs explícitos para referenciar)

-- -----------------------------------------
-- Poblar la tabla FECHA con registros completos y coherentes

INSERT INTO FECHA (id_fecha, fecha, día_semana, mes, año, Workday_weekend, estación, trimester)

VALUES

(1,'2023-01-05','Thursday',1,2023,TRUE,'Invierno',1),

(2,'2023-02-14','Tuesday',2,2023,TRUE,'Invierno',1),

(3,'2023-03-18','Saturday',3,2023,FALSE,'Primavera',1),

(4,'2023-04-25','Tuesday',4,2023,TRUE,'Primavera',2),

(5,'2023-05-07','Sunday',5,2023,FALSE,'Primavera',2),

(6,'2023-06-21','Wednesday',6,2023,TRUE,'Verano',2),

(7,'2023-07-15','Saturday',7,2023,FALSE,'Verano',3),

(8,'2023-08-10','Thursday',8,2023,TRUE,'Verano',3),

(9,'2023-09-09','Saturday',9,2023,FALSE,'Otoño',3),

(10,'2023-10-31','Tuesday',10,2023,TRUE,'Otoño',4),

(11,'2023-11-20','Monday',11,2023,TRUE,'Otoño',4),

(12,'2023-12-24','Sunday',12,2023,FALSE,'Invierno',4),

(13,'2024-01-10','Wednesday',1,2024,TRUE,'Invierno',1),

(14,'2024-02-29','Thursday',2,2024,TRUE,'Invierno',1), -- Año bisiesto

(15,'2024-03-17','Sunday',3,2024,FALSE,'Primavera',1),

(16,'2024-04-30','Tuesday',4,2024,TRUE,'Primavera',2),

(17,'2024-06-01','Saturday',6,2024,FALSE,'Verano',2),

(18,'2024-07-07','Sunday',7,2024,FALSE,'Verano',3),

(19,'2024-09-22','Sunday',9,2024,FALSE,'Otoño',3), -- Equinoccio

(20,'2024-12-31','Tuesday',12,2024,TRUE,'Invierno',4);

  
-- -----------------------------------------

-- 2) CIUDAD (incluye ciudad de origen + 2 extra por país)

-- -----------------------------------------

INSERT INTO CIUDAD (id_ciudad, nombre, código) VALUES

-- España (ES)

(1,'Oviedo','ES'), (2,'Madrid','ES'), (3,'Barcelona','ES'), (4,'Las Palmas de Gran Canaria','ES'),

-- Reino Unido (UK)

(5,'London','UK'), (6,'Manchester','UK'), (7,'Liverpool','UK'), (8,'Halifax','UK'),

-- Puerto Rico (PR)

(9,'San Juan','PR'), (10,'Ponce','PR'), (11,'Bayamón','PR'),

-- Cabo Verde (CV)

(12,'Mindelo','CV'), (13,'Praia','CV'), (14,'Santa Maria','CV'),

-- Corea del Sur (KR)

(15,'Seoul','KR'), (16,'Busan','KR'), (17,'Incheon','KR'),

-- Estados Unidos (US)

(18,'Reading','US'), (19,'Nashville','US'), (20,'Los Angeles','US'), (21,'New York','US'),

-- Alemania (DE)

(22,'Bonn','DE'), (23,'Berlin','DE'), (24,'Munich','DE'),

-- Rusia (RU)

(25,'Moscow','RU'), (26,'Saint Petersburg','RU'), (27,'Votkinsk','RU'),

-- Austria (AT)

(28,'Salzburg','AT'), (29,'Vienna','AT'), (30,'Linz','AT');
 
-- -----------------------------------------

-- 3) ARTISTAS (15 artistas)

-- -----------------------------------------

INSERT INTO ARTISTAS (artista_id, nombre, id_ciudad) VALUES

(1,'Melendi',1),

(2,'Queen',5),

(3,'Daddy Yankee',9),

(4,'Quevedo',4),

(5,'Led Zeppelin',5),

(6,'Cesária Évora',12),

(7,'BTS',15),

(8,'Taylor Swift',18),

(9,'Ludwig van Beethoven',22),

(10,'Pyotr Ilyich Tchaikovsky',27),

(11,'Rosalía',3),

(12,'Bad Bunny',9),

(13,'Ed Sheeran',8),

(14,'Metallica',20),

(15,'Wolfgang Amadeus Mozart',28);
 
-- -----------------------------------------

-- 4) CANCIONES (≥15; aquí 20 canciones con fecha y artista)

--     duracion en segundos aprox

--     id_fecha referencia a fechas ya creadas

-- -----------------------------------------

INSERT INTO CANCIONES (cancion_id, titulo, duracion, id_fecha, artista_id) VALUES

-- Melendi

(1,'Tu Jardín con Enanitos',245,3,1),

(2,'Lágrimas Desordenadas',230,2,1),

-- Queen

(3,'Bohemian Rhapsody',355,1,2),

(4,'Don’t Stop Me Now',210,4,2),

-- Daddy Yankee

(5,'Gasolina',193,3,3),

(6,'Dura',187,11,3),

-- Quevedo

(7,'Quédate (Bzrp Music Sessions, Vol. 52)',200,11,4),

(8,'Columbia',176,14,4),

-- Led Zeppelin

(9,'Stairway to Heaven',482,1,5),

(10,'Immigrant Song',146,2,5),

-- Cesária Évora

(11,'Sodade',255,4,6),

(12,'Besame Mucho (versión)',230,6,6),

-- BTS

(13,'Dynamite',199,10,7),

(14,'Butter',164,11,7),

-- Taylor Swift

(15,'Love Story',235,5,8),

(16,'Anti-Hero',201,13,8),

-- Beethoven

(17,'Für Elise',180,1,9),

(18,'Symphony No.5 (1st mov.)',425,1,9),

-- Tchaikovsky

(19,'Swan Lake Theme',210,1,10),

-- Metallica

(20,'Enter Sandman',331,1,14);
 
-- -----------------------------------------

-- 5) USUARIOS (15)

-- -----------------------------------------

INSERT INTO USUARIOS (usuario_id, nombre, correo_electronico, id_fecha_registro, id_ciudad) VALUES

(1,'Ana Gómez','ana.gomez@example.com',13,2),

(2,'Luis Pérez','luis.perez@example.com',13,3),

(3,'María López','maria.lopez@example.com',14,5),

(4,'Javier Ruiz','javier.ruiz@example.com',14,18),

(5,'Sofía Díaz','sofia.diaz@example.com',15,21),

(6,'Carlos Martín','carlos.martin@example.com',16,22),

(7,'Elena Torres','elena.torres@example.com',16,3),

(8,'Pablo Sánchez','pablo.sanchez@example.com',17,9),

(9,'Lucía Navarro','lucia.navarro@example.com',17,15),

(10,'Diego Romero','diego.romero@example.com',18,20),

(11,'Laura Vega','laura.vega@example.com',18,25),

(12,'Hugo Castillo','hugo.castillo@example.com',19,29),

(13,'Irene Campos','irene.campos@example.com',19,12),

(14,'Raúl Herrera','raul.herrera@example.com',20,6),

(15,'Nerea Prieto','nerea.prieto@example.com',20,28);
 
-- -----------------------------------------

-- 6) FAVORITOS (15 en total)

-- -----------------------------------------

INSERT INTO FAVORITOS (id_favorito, id_usuario, id_cancion, id_fecha) VALUES

(1,1,3,1),

(2,2,7,1),

(3,3,15,2),

(4,4,13,2),

(5,5,9,3),

(6,6,20,3),

(7,7,11,4),

(8,8,5,4),

(9,9,14,5),

(10,10,4,6),

(11,11,1,9),

(12,12,8,10),

(13,13,17,12),

(14,14,10,11),

(15,15,16,15);
 
-- -----------------------------------------

-- 7) EVENTOS_EN_VIVO (15)

--    fecha = id_fecha (FK a FECHA)

-- -----------------------------------------

INSERT INTO EVENTOS_EN_VIVO (id_evento, id_artista, nombre_evento, fecha, id_ciudad, duracion_min, descripcion) VALUES

(1,1,'Melendi en Madrid',2,2,120,'Gira peninsular'),

(2,2,'Queen + Adam Lambert - London',3,5,150,'Show especial'),

(3,3,'Daddy Yankee - San Juan',4,9,110,'Últimas giras'),

(4,4,'Quevedo - Las Palmas',1,4,90,'Show verano'),

(5,5,'Led Zeppelin Tribute - Manchester',19,6,100,'Tributo'),

(6,6,'Cesária Évora Homenaje - Mindelo',18,12,95,'Homenaje'),

(7,7,'BTS - Seoul Dome',17,15,140,'World Tour'),

(8,8,'Taylor Swift - Nashville',16,19,180,'The Eras Tour'),

(9,9,'Beethoven Sinfonías - Bonn',15,22,130,'Orquesta filarmónica'),

(10,10,'Tchaikovsky Gala - Moscow',14,25,125,'Gala ballet'),

(11,11,'Rosalía - Barcelona',13,3,100,'Motomami show'),

(12,12,'Bad Bunny - San Juan',12,9,120,'Stadium show'),

(13,13,'Ed Sheeran - London',11,5,115,'Mathematics Tour'),

(14,14,'Metallica - Los Angeles',10,20,140,'M72 world tour'),

(15,15,'Mozart Requiem - Salzburg',9,28,100,'Concierto barroco');
 
-- -----------------------------------------

-- 8) REPRODUCCIONES (15)

-- -----------------------------------------

INSERT INTO REPRODUCCIONES (id_reproduccion, id_usuario, id_cancion, fecha_reproduccion, duracion_reproducida, dispositivo, id_ciudad) VALUES

(1,1,7,2,180,'Mobile',2),

(2,2,3,20,340,'Desktop',3),

(3,3,13,13,190,'Tablet',5),

(4,4,15,15,220,'Mobile',18),

(5,5,20,2,300,'Desktop',21),

(6,6,11,18,240,'Mobile',22),

(7,7,9,17,470,'Desktop',3),

(8,8,5,1,185,'Mobile',9),

(9,9,14,5,160,'Mobile',15),

(10,10,4,9,200,'Desktop',20),

(11,11,1,19,220,'Mobile',2),

(12,12,8,19,170,'Tablet',12),

(13,13,17,18,175,'Desktop',12),

(14,14,10,18,140,'Mobile',6),

(15,15,16,17,190,'Tablet',28);
 
-- -----------------------------------------

-- -----------------------------------------



 