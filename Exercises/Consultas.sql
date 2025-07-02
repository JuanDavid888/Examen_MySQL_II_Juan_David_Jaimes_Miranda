-- Active: 1751458388058@@127.0.0.1@3307@examen_mysql

SHOW TABLES;

-- 1. Mostrar los empleados junto al país donde laboran.

SELECT
    em.nombre AS Empleado,
    pa.nombre AS Pais
FROM empleados em
JOIN sucursal su ON em.sucursal_id = su.id
JOIN municipio mu ON su.municipio_id = mu.id
JOIN departamento dep ON mu.departamento_id = dep.id
JOIN pais pa ON dep.pais_id = pa.id;

-- 2. Listar el nombre de cada cliente con su municipio, departamento y país.

SELECT
    cl.nombre AS Nombre,
    mu.nombre AS Municipio,
    dep.nombre AS Departamento,
    pa.nombre AS Pais
FROM clientes cl
JOIN municipio mu ON cl.municipio_id = mu.id
JOIN departamento dep ON mu.departamento_id = dep.id
JOIN pais pa ON dep.pais_id = pa.id;

-- 3. Obtener los nombres de los empleados cuyo puesto existe en más de una sucursal.

SELECT 
    em.nombre AS Nombre,
    em.puesto AS Puesto
FROM empleados em
JOIN sucursal su ON em.sucursal_id = su.id
WHERE em.puesto IN (em.sucursal_id IN (1,2,3,4,5,6,7,8,9,10))

-- 4. Mostrar el total de empleados por municipio y el nombre del departamento al que pertenecen.

SELECT
    mu.nombre AS Municipio,
    dep.nombre AS Departamento,
    COUNT(em.id) AS Total_empleados
FROM empleados em
JOIN sucursal su ON em.sucursal_id = su.id
JOIN municipio mu ON su.municipio_id = mu.id
JOIN departamento dep ON mu.departamento_id = dep.id
GROUP BY mu.nombre, dep.nombre;