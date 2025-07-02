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