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