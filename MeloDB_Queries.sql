/* =========================================================

   50 QUERIES PARA MELODB

   Nota: Usa funciones de fecha sobre FECHA.fecha.

========================================================= */
 
-- 1) Nº de canciones por artista (INNER JOIN + COUNT)

SELECT a.nombre AS artista, COUNT(c.cancion_id) AS num_canciones

FROM ARTISTAS a

JOIN CANCIONES c ON c.artista_id = a.artista_id

GROUP BY a.artista_id, a.nombre

ORDER BY num_canciones DESC, artista;
 
-- 2) Reproducciones por canción (INNER JOIN + COUNT)

SELECT c.titulo, a.nombre AS artista, COUNT(r.id_reproduccion) AS reproducciones

FROM CANCIONES c

JOIN ARTISTAS a ON a.artista_id = c.artista_id

LEFT JOIN REPRODUCCIONES r ON r.id_cancion = c.cancion_id

GROUP BY c.cancion_id, c.titulo, a.nombre

ORDER BY reproducciones DESC, titulo;
 
-- 3) Usuarios por ciudad (LEFT JOIN + COUNT DISTINCT)

SELECT ci.nombre AS ciudad, ci.`código` AS pais, COUNT(DISTINCT u.usuario_id) AS usuarios

FROM CIUDAD ci

LEFT JOIN USUARIOS u ON u.id_ciudad = ci.id_ciudad

GROUP BY ci.id_ciudad, ci.nombre, ci.`código`

ORDER BY usuarios DESC, ciudad;
 
-- 4) Favoritos por usuario (LEFT JOIN + COUNT)

SELECT u.usuario_id, u.nombre, COUNT(f.id_favorito) AS num_favoritos

FROM USUARIOS u

LEFT JOIN FAVORITOS f ON f.id_usuario = u.usuario_id

GROUP BY u.usuario_id, u.nombre

ORDER BY num_favoritos DESC, u.nombre;
 
-- 5) TOP 5 canciones más reproducidas (ORDER + LIMIT)

SELECT c.titulo, a.nombre AS artista, COUNT(r.id_reproduccion) AS reproducciones

FROM REPRODUCCIONES r

JOIN CANCIONES c ON c.cancion_id = r.id_cancion

JOIN ARTISTAS a ON a.artista_id = c.artista_id

GROUP BY c.cancion_id, c.titulo, a.nombre

ORDER BY reproducciones DESC

LIMIT 5;
 
-- 6) Reproducciones por dispositivo (GROUP BY)

SELECT dispositivo, COUNT(*) AS total

FROM REPRODUCCIONES

GROUP BY dispositivo

ORDER BY total DESC;
 
-- 7) Canciones por pais de origen del artista

SELECT ci.`código` AS pais, COUNT(c.cancion_id) AS num_canciones
FROM CANCIONES c
JOIN ARTISTAS a ON a.artista_id = c.artista_id
JOIN CIUDAD ci ON ci.id_ciudad = a.id_ciudad
GROUP BY ci.`código`
ORDER BY num_canciones DESC;
 
-- 8) Artistas por país (JOIN + COUNT DISTINCT)

SELECT ci.`código` AS pais, COUNT(DISTINCT a.artista_id) AS artistas

FROM ARTISTAS a

JOIN CIUDAD ci ON ci.id_ciudad = a.id_ciudad

GROUP BY ci.`código`

ORDER BY artistas DESC, pais;
 
-- 9) Canciones más largas (TOP 10) (ORDER + LIMIT)

SELECT c.titulo, a.nombre AS artista, c.duracion

FROM CANCIONES c

JOIN ARTISTAS a ON a.artista_id = c.artista_id

ORDER BY c.duracion DESC

LIMIT 10;
 
-- 10) Duración media de canción por artista (AVG)

SELECT a.nombre AS artista, ROUND(AVG(c.duracion),2) AS duracion_media_seg

FROM ARTISTAS a

JOIN CANCIONES c ON c.artista_id = a.artista_id

GROUP BY a.artista_id, a.nombre

ORDER BY duracion_media_seg DESC;
 
-- 11) Usuarios registrados por año (USUARIOS -> FECHA) (YEAR)

SELECT YEAR(f.fecha) AS anio, COUNT(*) AS nuevos_usuarios

FROM USUARIOS u

JOIN FECHA f ON f.id_fecha = u.id_fecha_registro

GROUP BY YEAR(f.fecha)

ORDER BY anio;
 
-- 12) Reproducciones por año (REPRODUCCIONES -> FECHA)

SELECT YEAR(f.fecha) AS anio, COUNT(*) AS reproducciones

FROM REPRODUCCIONES r

JOIN FECHA f ON f.id_fecha = r.fecha_reproduccion

GROUP BY YEAR(f.fecha)

ORDER BY anio;
 
-- 13) Eventos por ciudad (COUNT)

SELECT ci.nombre AS ciudad, COUNT(e.id_evento) AS eventos

FROM CIUDAD ci

LEFT JOIN EVENTOS_EN_VIVO e ON e.id_ciudad = ci.id_ciudad

GROUP BY ci.id_ciudad, ci.nombre

ORDER BY eventos DESC, ciudad;
 
-- 14) Próximos eventos (fecha >= '2025-01-01') (filtro)

SELECT e.nombre_evento, a.nombre AS artista, ci.nombre AS ciudad, f.fecha

FROM EVENTOS_EN_VIVO e

JOIN ARTISTAS a ON a.artista_id = e.id_artista

JOIN CIUDAD ci ON ci.id_ciudad = e.id_ciudad

JOIN FECHA f ON f.id_fecha = e.fecha

WHERE f.fecha >= '2025-01-01'

ORDER BY f.fecha;
 
-- 15) Canciones con más de 5 reproducciones

SELECT c.titulo, a.nombre AS artista, COUNT(r.id_reproduccion) AS total_repros
FROM CANCIONES c
JOIN ARTISTAS a ON a.artista_id = c.artista_id
JOIN REPRODUCCIONES r ON r.id_cancion = c.cancion_id
GROUP BY c.cancion_id, c.titulo, a.nombre
HAVING COUNT(r.id_reproduccion) > 1
ORDER BY total_repros DESC;
 
-- 16) Canciones favoritas (más marcadas en FAVORITOS)

SELECT c.titulo, a.nombre AS artista, COUNT(f.id_favorito) AS veces_favorita

FROM CANCIONES c

JOIN ARTISTAS a ON a.artista_id = c.artista_id

LEFT JOIN FAVORITOS f ON f.id_cancion = c.cancion_id

GROUP BY c.cancion_id, c.titulo, a.nombre

ORDER BY veces_favorita DESC, c.titulo;
 
-- 17) Usuarios con >1 favorito (subconsulta HAVING)

SELECT u.usuario_id, u.nombre, COUNT(*) AS favoritos

FROM FAVORITOS f

JOIN USUARIOS u ON u.usuario_id = f.id_usuario

GROUP BY u.usuario_id, u.nombre

HAVING COUNT(*) > 1

ORDER BY favoritos DESC;
 
-- 18) Canciones por ciudad del usuario
SELECT ci.nombre AS ciudad, COUNT(f.id_favorito) AS favoritos
FROM FAVORITOS f
JOIN USUARIOS u ON u.usuario_id = f.id_usuario
JOIN CIUDAD ci ON ci.id_ciudad = u.id_ciudad
GROUP BY ci.id_ciudad, ci.nombre
ORDER BY favoritos DESC; 
-- 19) Artistas sin reproducciones (LEFT JOIN + IS NULL)

SELECT a.artista_id, a.nombre

FROM ARTISTAS a

LEFT JOIN CANCIONES c ON c.artista_id = a.artista_id

LEFT JOIN REPRODUCCIONES r ON r.id_cancion = c.cancion_id

GROUP BY a.artista_id, a.nombre

HAVING COUNT(r.id_reproduccion) = 0;
 
-- 20) Canciones más reproducidas por país del ARTISTA

SELECT ci.`código` AS pais, c.titulo, a.nombre AS artista, COUNT(r.id_reproduccion) AS repros,

       ROW_NUMBER() OVER (PARTITION BY ci.`código` ORDER BY COUNT(r.id_reproduccion) DESC) AS rn

FROM REPRODUCCIONES r

JOIN CANCIONES c ON c.cancion_id = r.id_cancion

JOIN ARTISTAS a ON a.artista_id = c.artista_id

JOIN CIUDAD ci ON ci.id_ciudad = a.id_ciudad

GROUP BY ci.`código`, c.cancion_id, c.titulo, a.nombre;

-- QUALIFY rn = 1; -- Si tu MySQL no soporta QUALIFY, usa una CTE (ver Query 21).
 
-- 21) (Alternativa a 20 con CTE)

WITH repros AS (

  SELECT ci.`código` AS pais, c.cancion_id, c.titulo, a.nombre,

         COUNT(r.id_reproduccion) AS repros,

         ROW_NUMBER() OVER (PARTITION BY ci.`código` ORDER BY COUNT(r.id_reproduccion) DESC) AS rn

  FROM REPRODUCCIONES r

  JOIN CANCIONES c ON c.cancion_id = r.id_cancion

  JOIN ARTISTAS a ON a.artista_id = c.artista_id

  JOIN CIUDAD ci ON ci.id_ciudad = a.id_ciudad

  GROUP BY ci.`código`, c.cancion_id, c.titulo, a.nombre

)

SELECT pais, titulo, nombre AS artista, repros

FROM repros

WHERE rn = 1;
 
-- 22) Promedio de duración reproducida por dispositivo (AVG)

SELECT dispositivo, ROUND(AVG(duracion_reproducida),2) AS avg_seg

FROM REPRODUCCIONES

GROUP BY dispositivo

ORDER BY avg_seg DESC;
 
-- 23) % de usuarios por pais

SELECT ci.`código` AS pais,
       COUNT(u.usuario_id) AS num_usuarios,
       ROUND(100 * COUNT(u.usuario_id) / (SELECT COUNT(*) FROM USUARIOS),2) AS porcentaje
FROM USUARIOS u
JOIN CIUDAD ci ON ci.id_ciudad = u.id_ciudad
GROUP BY ci.`código`
ORDER BY num_usuarios DESC; 


-- 24) Usuarios que han reproducido canciones de un artista concreto (ej: Queen)

SELECT COUNT(DISTINCT r.id_usuario) AS usuarios_queen

FROM REPRODUCCIONES r

JOIN CANCIONES c ON c.cancion_id = r.id_cancion

JOIN ARTISTAS a ON a.artista_id = c.artista_id

WHERE a.nombre = 'Queen';

 
-- 25) Reproducciones por mes (DATE_FORMAT)

SELECT DATE_FORMAT(f.fecha, '%Y-%m') AS mes, COUNT(*) AS reproducciones

FROM REPRODUCCIONES r

JOIN FECHA f ON f.id_fecha = r.fecha_reproduccion

GROUP BY DATE_FORMAT(f.fecha, '%Y-%m')

ORDER BY mes;
 
 -- 26) TOP 3 canciones por artista según favoritos (window)

WITH favs AS (

  SELECT a.artista_id, a.nombre AS artista, c.cancion_id, c.titulo,

         COUNT(f.id_favorito) AS favs,

         DENSE_RANK() OVER (PARTITION BY a.artista_id ORDER BY COUNT(f.id_favorito) DESC) AS rk

  FROM ARTISTAS a

  JOIN CANCIONES c ON c.artista_id = a.artista_id

  LEFT JOIN FAVORITOS f ON f.id_cancion = c.cancion_id

  GROUP BY a.artista_id, a.nombre, c.cancion_id, c.titulo

)

SELECT artista, titulo, favs

FROM favs

WHERE rk <= 3

ORDER BY artista, favs DESC, titulo;
 
-- 27) Canciones por encima de la duración media global (subconsulta)

SELECT c.titulo, a.nombre AS artista, c.duracion

FROM CANCIONES c

JOIN ARTISTAS a ON a.artista_id = c.artista_id

WHERE c.duracion > (SELECT AVG(duracion) FROM CANCIONES)

ORDER BY c.duracion DESC;
 
-- 28) Canciones por encima de la duración media de su ARTISTA (correlated subquery)

SELECT c.titulo, a.nombre AS artista, c.duracion

FROM CANCIONES c

JOIN ARTISTAS a ON a.artista_id = c.artista_id

WHERE c.duracion > (

  SELECT AVG(c2.duracion) FROM CANCIONES c2 WHERE c2.artista_id = c.artista_id

)

ORDER BY artista, c.duracion DESC;
 
-- 29) Artistas con eventos en 2025 (EXISTS)

SELECT DISTINCT a.nombre AS artista

FROM ARTISTAS a

WHERE EXISTS (

  SELECT 1

  FROM EVENTOS_EN_VIVO e

  JOIN FECHA f ON f.id_fecha = e.fecha

  WHERE e.id_artista = a.artista_id

    AND YEAR(f.fecha) = 2025

)

ORDER BY artista;
 
-- 30) Ciudades sin usuarios (LEFT JOIN + IS NULL)

SELECT ci.nombre AS ciudad, ci.`código` AS pais

FROM CIUDAD ci

LEFT JOIN USUARIOS u ON u.id_ciudad = ci.id_ciudad

WHERE u.usuario_id IS NULL

ORDER BY pais, ciudad;
 
-- 31) Media, min y max de reproducciones por usuario

SELECT u.usuario_id, u.nombre,
       COUNT(r.id_reproduccion) AS total_repros,
       MIN(r.duracion_reproducida) AS min_seg,
       MAX(r.duracion_reproducida) AS max_seg,
       ROUND(AVG(r.duracion_reproducida),2) AS avg_seg
FROM USUARIOS u
LEFT JOIN REPRODUCCIONES r ON r.id_usuario = u.usuario_id
GROUP BY u.usuario_id, u.nombre
ORDER BY total_repros DESC;
-- 32) TOP 5 usuarios más activos (por reproducciones)

SELECT u.usuario_id, u.nombre, COUNT(r.id_reproduccion) AS reproducciones

FROM USUARIOS u

LEFT JOIN REPRODUCCIONES r ON r.id_usuario = u.usuario_id

GROUP BY u.usuario_id, u.nombre

ORDER BY reproducciones DESC

LIMIT 5;
 
-- 33) Reproducciones por país de USUARIO (JOIN a CIUDAD del usuario)

SELECT ci.`código` AS pais_usuario, COUNT(*) AS reproducciones

FROM REPRODUCCIONES r

JOIN USUARIOS u ON u.usuario_id = r.id_usuario

JOIN CIUDAD ci ON ci.id_ciudad = u.id_ciudad

GROUP BY ci.`código`

ORDER BY reproducciones DESC;
 
-- 34) Relación favoritos vs reproducciones por canción (2 subconsultas unidas)

SELECT c.cancion_id, c.titulo,

       COALESCE( (SELECT COUNT(*) FROM FAVORITOS f WHERE f.id_cancion = c.cancion_id), 0) AS favs,

       COALESCE( (SELECT COUNT(*) FROM REPRODUCCIONES r WHERE r.id_cancion = c.cancion_id), 0) AS repros

FROM CANCIONES c

ORDER BY repros DESC, favs DESC;
 
-- 35) Usuarios que NO tienen favoritos (NOT EXISTS)

SELECT u.usuario_id, u.nombre

FROM USUARIOS u

WHERE NOT EXISTS (

  SELECT 1 FROM FAVORITOS f WHERE f.id_usuario = u.usuario_id

)

ORDER BY u.nombre;
 
-- 36) Día con más reproducciones (GROUP + ORDER + LIMIT)

SELECT f.fecha, COUNT(*) AS reproducciones

FROM REPRODUCCIONES r

JOIN FECHA f ON f.id_fecha = r.fecha_reproduccion

GROUP BY f.fecha

ORDER BY reproducciones DESC

LIMIT 1;
 
-- 37) Canciones nunca reproducidas (LEFT JOIN + IS NULL)

SELECT c.cancion_id, c.titulo, a.nombre AS artista

FROM CANCIONES c

JOIN ARTISTAS a ON a.artista_id = c.artista_id

LEFT JOIN REPRODUCCIONES r ON r.id_cancion = c.cancion_id

WHERE r.id_reproduccion IS NULL

ORDER BY artista, titulo;
 
-- 38) Reproducciones por artista y dispositivo (multi-join)

SELECT a.nombre AS artista, r.dispositivo, COUNT(*) AS reproducciones

FROM REPRODUCCIONES r

JOIN CANCIONES c ON c.cancion_id = r.id_cancion

JOIN ARTISTAS a ON a.artista_id = c.artista_id

GROUP BY a.nombre, r.dispositivo

ORDER BY artista, reproducciones DESC;
 
-- 39) TOP 1 canción por ciudad de usuario (window)

WITH base AS (

  SELECT ci.nombre AS ciudad_usuario, c.cancion_id, c.titulo,

         COUNT(*) AS repros,

         ROW_NUMBER() OVER (PARTITION BY ci.nombre ORDER BY COUNT(*) DESC) AS rn

  FROM REPRODUCCIONES r

  JOIN USUARIOS u ON u.usuario_id = r.id_usuario

  JOIN CIUDAD ci ON ci.id_ciudad = u.id_ciudad

  JOIN CANCIONES c ON c.cancion_id = r.id_cancion

  GROUP BY ci.nombre, c.cancion_id, c.titulo

)

SELECT ciudad_usuario, titulo, repros

FROM base

WHERE rn = 1

ORDER BY ciudad_usuario;
 
-- 40) Eventos por país y año (GROUP BY múltiples)

SELECT ci.`código` AS pais, YEAR(f.fecha) AS anio, COUNT(*) AS eventos

FROM EVENTOS_EN_VIVO e

JOIN CIUDAD ci ON ci.id_ciudad = e.id_ciudad

JOIN FECHA f ON f.id_fecha = e.fecha

GROUP BY ci.`código`, YEAR(f.fecha)

ORDER BY eventos DESC;
 
-- 41) Canciones agregadas por año (canción->id_fecha->FECHA)

SELECT YEAR(f.fecha) AS anio, COUNT(*) AS canciones_creadas

FROM CANCIONES c

JOIN FECHA f ON f.id_fecha = c.id_fecha

GROUP BY YEAR(f.fecha)

ORDER BY anio;
 
-- 42) Promedio de duración reproducida vs. duración de la canción

SELECT c.titulo, a.nombre AS artista,

       c.duracion AS duracion_cancion,

       ROUND(AVG(r.duracion_reproducida),2) AS duracion_media_repro

FROM CANCIONES c

JOIN ARTISTAS a ON a.artista_id = c.artista_id

JOIN REPRODUCCIONES r ON r.id_cancion = c.cancion_id

GROUP BY c.cancion_id, c.titulo, a.nombre, c.duracion

ORDER BY (AVG(r.duracion_reproducida)/c.duracion) DESC;
 
-- 43) Usuarios que han reproducido al menos 3 artistas distintos (HAVING)

SELECT u.usuario_id, u.nombre, COUNT(DISTINCT a.artista_id) AS artistas_distintos

FROM REPRODUCCIONES r

JOIN USUARIOS u ON u.usuario_id = r.id_usuario

JOIN CANCIONES c ON c.cancion_id = r.id_cancion

JOIN ARTISTAS a ON a.artista_id = c.artista_id

GROUP BY u.usuario_id, u.nombre

HAVING COUNT(DISTINCT a.artista_id) >= 3

ORDER BY artistas_distintos DESC, u.nombre;
 
-- 44) Canciones añadidas a favoritos pero sin reproducciones (LEFT JOIN + IS NULL)

SELECT c.titulo, a.nombre AS artista

FROM FAVORITOS f

JOIN CANCIONES c ON c.cancion_id = f.id_cancion

JOIN ARTISTAS a ON a.artista_id = c.artista_id

LEFT JOIN REPRODUCCIONES r ON r.id_cancion = c.cancion_id

GROUP BY c.cancion_id, c.titulo, a.nombre

HAVING COUNT(r.id_reproduccion) = 0;
 
-- 45) Media de favoritos por usuario (AVG sobre agregación)

SELECT ROUND(AVG(cnt),2) AS media_favoritos_por_usuario

FROM (

  SELECT u.usuario_id, COUNT(f.id_favorito) AS cnt

  FROM USUARIOS u

  LEFT JOIN FAVORITOS f ON f.id_usuario = u.usuario_id

  GROUP BY u.usuario_id

) t;
 
-- 46) Artistas con eventos en la misma ciudad de origen (JOIN y comparación)

SELECT a.nombre AS artista, ci.nombre AS ciudad

FROM EVENTOS_EN_VIVO e

JOIN ARTISTAS a ON a.artista_id = e.id_artista

JOIN CIUDAD ci ON ci.id_ciudad = e.id_ciudad

WHERE e.id_ciudad = a.id_ciudad

GROUP BY a.nombre, ci.nombre;
 
-- 47) Usuarios y su primera reproducción (MIN FECHA con subconsulta)

SELECT u.usuario_id, u.nombre,

       (SELECT MIN(f.fecha)

        FROM REPRODUCCIONES r2

        JOIN FECHA f ON f.id_fecha = r2.fecha_reproduccion

        WHERE r2.id_usuario = u.usuario_id) AS primera_fecha_repro

FROM USUARIOS u

ORDER BY primera_fecha_repro;
 
-- 48) Ranking global de artistas por reproducciones (SUM + window)

WITH by_artist AS (

  SELECT a.artista_id, a.nombre,

         COUNT(r.id_reproduccion) AS repros

  FROM ARTISTAS a

  JOIN CANCIONES c ON c.artista_id = a.artista_id

  LEFT JOIN REPRODUCCIONES r ON r.id_cancion = c.cancion_id

  GROUP BY a.artista_id, a.nombre

)

SELECT nombre AS artista, repros,

       DENSE_RANK() OVER (ORDER BY repros DESC) AS ranking

FROM by_artist

ORDER BY ranking, artista;
 
-- 49) País con más usuarios activos (reproducen algo) (DISTINCT)

SELECT ci.`código` AS pais, COUNT(DISTINCT r.id_usuario) AS usuarios_activos

FROM REPRODUCCIONES r

JOIN USUARIOS u ON u.usuario_id = r.id_usuario

JOIN CIUDAD ci ON ci.id_ciudad = u.id_ciudad

GROUP BY ci.`código`

ORDER BY usuarios_activos DESC

LIMIT 1;
 
-- 50) Distribución de reproducciones por hora del día (si FECHA.hora existiera)

-- Como no hay hora, usamos solo fecha: ejemplo de placeholder con 00:00

-- (Muestra cómo sería si añadieras un campo DATETIME en REPRODUCCIONES).

-- SELECT HOUR(rts) AS hora, COUNT(*) FROM REPRODUCCIONES GROUP BY HOUR(rts);

-- Alternativa útil actual: reproducción por día de semana calculado al vuelo

SELECT DAYNAME(f.fecha) AS dia_semana, COUNT(*) AS reproducciones

FROM REPRODUCCIONES r

JOIN FECHA f ON f.id_fecha = r.fecha_reproduccion

GROUP BY DAYNAME(f.fecha)

ORDER BY reproducciones DESC;
 