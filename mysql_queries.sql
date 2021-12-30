-- Base de dades Tienda
USE tienda;
SELECT nombre FROM producto;
SELECT nombre, precio FROM producto;
SELECT * FROM producto;
SELECT nombre, precio, ROUND (precio * 1.13, 2) FROM producto;
SELECT nombre AS 'nom de producto', precio AS 'euros', ROUND (precio * 1.13, 2) AS 'dòlars nord-americans' FROM producto;
SELECT UPPER (nombre) AS nombre, precio FROM producto;
SELECT LOWER (nombre) AS nombre, precio FROM producto;
SELECT nombre, UPPER (SUBSTRING(nombre, 1,2)) AS "primeros caracteres" FROM fabricante;
SELECT nombre, ROUND (precio) AS "precio redondeado" FROM producto;
SELECT nombre, TRUNCATE (precio, 0) AS "precio sin decimales" FROM producto;
SELECT fabricante.codigo, producto.codigo_fabricante  FROM fabricante INNER JOIN producto ON fabricante.codigo = producto.codigo_fabricante;
SELECT DISTINCT fabricante.codigo, producto.codigo_fabricante  FROM fabricante INNER JOIN producto ON fabricante.codigo = producto.codigo_fabricante;
SELECT nombre FROM fabricante ORDER BY nombre ASC;
SELECT nombre FROM fabricante ORDER BY nombre DESC;
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;
SELECT * FROM fabricante LIMIT 5;
SELECT * FROM fabricante LIMIT 3,2;
SELECT nombre, precio FROM producto ORDER BY precio LIMIT 1;
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
SELECT nombre FROM producto WHERE codigo_fabricante = 2;
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante;
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante ORDER BY fabricante.nombre;
SELECT producto.nombre, producto.precio, producto.codigo_fabricante, fabricante.nombre FROM producto INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante;
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante ORDER BY precio LIMIT 1;
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante ORDER BY precio DESC LIMIT 1;
SELECT producto.nombre FROM producto JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante WHERE fabricante.nombre REGEXP "lenovo";
SELECT producto.nombre FROM producto JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante WHERE fabricante.nombre REGEXP "crucial" AND precio > 200;
SELECT producto.nombre FROM producto JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante WHERE fabricante.nombre REGEXP "Asus|Hewlett-Packard|Seagate"; 
SELECT producto.nombre FROM producto JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante WHERE fabricante.nombre IN ("Asus","Hewlett-Packard","Seagate");
SELECT producto.nombre, precio FROM producto JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante WHERE fabricante.nombre LIKE "%e";
SELECT producto.nombre, precio FROM producto JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante WHERE fabricante.nombre LIKE "%w%";
SELECT producto.nombre, precio, fabricante.nombre FROM producto JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante WHERE precio >= 180 ORDER BY precio DESC, producto.nombre;
SELECT DISTINCT fabricante.codigo, fabricante.nombre FROM producto JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante;
SELECT fabricante.codigo, fabricante.nombre, producto.nombre AS producto FROM producto RIGHT JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante;
SELECT fabricante.codigo, fabricante.nombre FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante WHERE producto.nombre IS NULL;
SELECT producto.nombre, fabricante.nombre AS fabricante FROM producto, fabricante WHERE producto.codigo_fabricante = fabricante.codigo AND fabricante.nombre REGEXP "lenovo";
SELECT producto.nombre, precio, codigo_fabricante, fabricante.nombre FROM producto, fabricante WHERE producto.codigo_fabricante = fabricante.codigo AND producto.precio= (SELECT MAX(precio) FROM producto, fabricante WHERE producto.codigo_fabricante = fabricante.codigo AND fabricante.nombre REGEXP "lenovo");
SELECT producto.nombre, MAX(precio) FROM producto, fabricante WHERE producto.codigo_fabricante = fabricante.codigo AND fabricante.nombre REGEXP "lenovo";
SELECT producto.nombre, MIN(precio) FROM producto, fabricante WHERE producto.codigo_fabricante = fabricante.codigo AND fabricante.nombre REGEXP "Hewlett-Packard";
SELECT producto.nombre AS "nombre producto", precio AS "precio superior a la media", fabricante.nombre AS fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre REGEXP "asus" AND producto.precio > (SELECT AVG(precio) FROM producto, fabricante WHERE producto.codigo_fabricante = fabricante.codigo AND fabricante.nombre REGEXP "asus");

-- Base de dades Universidad
USE universidad;
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo REGEXP "alumno" ORDER BY apellido1;
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo REGEXP "alumno" AND telefono IS NULL;
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo REGEXP "alumno" AND fecha_nacimiento LIKE "1999%";
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo REGEXP "profesor" AND telefono IS NULL AND nif LIKE "%K";
SELECT nombre FROM asignatura WHERE cuatrimestre REGEXP "1" AND curso REGEXP "3" AND id_grado REGEXP "7";
SELECT apellido1,apellido2, persona.nombre, departamento.nombre AS departamento FROM persona JOIN profesor ON persona.id = profesor.id_profesor JOIN departamento ON profesor.id_departamento = departamento.id ORDER BY apellido1, apellido2, nombre;
SELECT a.nombre, anyo_inicio, anyo_fin FROM alumno_se_matricula_asignatura ama JOIN asignatura a ON ama.id_asignatura = a.id JOIN curso_escolar ce ON ama.id_curso_escolar = ce.id JOIN persona ON persona.id = ama.id_alumno WHERE nif REGEXP "26902806M";
SELECT DISTINCT d.nombre AS departamento FROM departamento d JOIN profesor p ON d.id = p.id_departamento JOIN asignatura a USING (id_profesor) JOIN grado g ON a.id_grado = g.id  WHERE g.id = "4";
SELECT DISTINCT p.id, p.nif, p.nombre, p.apellido1, p.apellido2 FROM persona p JOIN alumno_se_matricula_asignatura ama ON p.id = ama.id_alumno JOIN asignatura a ON ama.id_asignatura = a.id JOIN curso_escolar ce ON ama.id_curso_escolar = ce.id WHERE p.tipo = "alumno" AND ce.anyo_inicio = "2018" AND ce.anyo_fin = "2019";

--  Consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN
SELECT d.nombre AS departamento, p.apellido1, p.apellido2, p.nombre FROM persona p JOIN profesor pf ON p.id = pf.id_profesor LEFT JOIN departamento d ON pf.id_departamento = d.id ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;
SELECT p.apellido1, p.apellido2, p.nombre FROM persona p JOIN profesor pf ON p.id = pf.id_profesor LEFT JOIN departamento d ON pf.id_departamento = d.id WHERE pf.id_departamento IS NULL;
SELECT d.nombre AS departamento, p.apellido1, p.apellido2, p.nombre FROM persona p JOIN profesor pf ON p.id = pf.id_profesor RIGHT JOIN departamento d ON pf.id_departamento = d.id WHERE p.apellido1 IS NULL AND p.apellido2 IS NULL AND p.nombre IS NULL;
SELECT DISTINCT a.nombre AS asignatura, p.apellido1, p.apellido2, p.nombre FROM persona p JOIN profesor pf ON p.id = pf.id_profesor LEFT JOIN asignatura a ON pf.id_profesor = a.id_profesor WHERE a.nombre IS NULL;
SELECT DISTINCT a.nombre AS asignatura, p.apellido1, p.apellido2, p.nombre FROM persona p JOIN profesor pf ON p.id = pf.id_profesor RIGHT JOIN asignatura a ON pf.id_profesor = a.id_profesor WHERE p.apellido1 IS NULL AND p.apellido2 IS NULL AND p.nombre IS NULL;
SELECT DISTINCT d.nombre AS departamento, a.nombre AS asignatura FROM departamento d JOIN profesor pf ON d.id = pf.id_departamento JOIN asignatura a ON pf.id_profesor = a.id_profesor LEFT JOIN alumno_se_matricula_asignatura ama ON a.id = ama.id_asignatura WHERE ama.id_curso_escolar IS NULL;

-- Consultes resum
SELECT COUNT(persona.id) AS "Número de alumnos" FROM persona WHERE tipo = "alumno";
SELECT COUNT(persona.id) AS "Alumnos nacidos en 1999" FROM persona WHERE fecha_nacimiento LIKE "1999%";
SELECT d.nombre AS "Departamento", COUNT(p.id_profesor) AS "Número de profesores" FROM profesor p JOIN departamento d ON p.id_departamento = d.id GROUP BY d.nombre ORDER BY COUNT(p.id_profesor) DESC;
SELECT d.nombre AS "Departamento", COUNT(p.id_profesor) AS "Número de profesores" FROM profesor p RIGHT JOIN departamento d ON p.id_departamento = d.id GROUP BY d.nombre;
SELECT g.nombre AS "Grado", COUNT(a.id) AS "Nro asignaturas asociadas" FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre ORDER BY COUNT(a.id);
SELECT g.nombre AS "Grado", COUNT(a.id) AS "Nro asignaturas asociadas" FROM grado g JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre HAVING COUNT(a.id) > 40;
SELECT g.nombre AS "Grado", a.tipo AS "Tipo de asignatura", SUM(a.creditos) AS "Nro créditos" FROM grado g JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre, a.tipo;
SELECT ce.anyo_inicio AS "Año inicio curso escolar", COUNT(ama.id_alumno) AS "Número alumnos matriculados" FROM curso_escolar ce JOIN alumno_se_matricula_asignatura ama ON ce.id = ama.id_curso_escolar GROUP BY ce.anyo_inicio; 
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS "Número de asignaturas" FROM persona p LEFT JOIN asignatura a ON p.id = a.id_profesor WHERE p.tipo = "profesor" GROUP BY p.id ORDER BY COUNT(a.id) DESC;
SELECT * FROM persona WHERE fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona WHERE tipo = "alumno");
SELECT p.id, p.nif, p.nombre, p.apellido1, p.apellido2, COUNT(d.id) AS "Nro departamentos asociados", d.nombre AS "Departamento", a.nombre AS "Asignatura" FROM persona p JOIN profesor pf ON p.id = pf.id_profesor LEFT JOIN asignatura a USING (id_profesor) JOIN departamento d ON pf.id_departamento = d.id  WHERE a.nombre IS NULL GROUP BY p.id;