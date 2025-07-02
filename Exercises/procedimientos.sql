-- Active: 1751458388058@@127.0.0.1@3307@examen_mysql

SHOW TABLES;

-- 1. Cree un procedimiento llamado `ps_registrar_cliente_unico`  que inserta un nuevo cliente si su correo no está registrado.

DELIMITER $$

DROP PROCEDURE IF EXISTS ps_registrar_cliente_unico $$

CREATE PROCEDURE ps_registrar_cliente_unico(
    IN c_nombre VARCHAR(80),
    IN c_correo VARCHAR(50),
    IN c_telefono VARCHAR(15),
    IN c_direccion VARCHAR(50),
    IN c_fecha_registro DATETIME,
    IN c_municipio_id INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM clientes WHERE nombre = c_nombre) THEN
        SIGNAL SQLSTATE '40001'
            SET MESSAGE_TEXT = 'Ese nombre ya existe';
    END IF;

    IF EXISTS (SELECT 1 FROM clientes WHERE correo = c_correo) THEN
        SIGNAL SQLSTATE '40001'
            SET MESSAGE_TEXT = 'Ese correo ya existe';
    END IF;

    IF c_fecha_registro > NOW() THEN
        SIGNAL SQLSTATE '40001'
            SET MESSAGE_TEXT = 'La fecha no puede ser mayor a la de hoy';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM municipio WHERE id = c_municipio_id) THEN
        SIGNAL SQLSTATE '40002'
            SET MESSAGE_TEXT = 'El municipio no existe';
    END IF;

    INSERT INTO clientes (nombre, email, telefono, direccion, fecha_registro, municipio_id)
    VALUES(c_nombre, c_correo, c_telefono, c_direccion, c_fecha_registro, c_municipio_id);

END $$

DELIMITER ;

CALL ps_registrar_cliente_unico(
  'Adrian Ruiz', 
  'adrian.ruiz@gmail.com', 
  '3123456789', 
  'Calle 123 #45-67', 
  '2025-02-01', 
  5
);

-- 2. Cree un procedimiento por nombre `ps_obtener_clientes_por_municipio` donde liste todos los clientes de un municipio .

DELIMITER $$

DROP PROCEDURE IF EXISTS ps_obtener_clientes_por_municipio $$

CREATE PROCEDURE ps_obtener_clientes_por_municipio(
    IN c_municipio_nombre VARCHAR(80)
)
BEGIN
    SELECT
        cl.nombre,
        cl.email,
        cl.telefono,
        cl.direccion
    FROM clientes cl
    JOIN municipio mu ON cl.municipio_id = mu.id
    WHERE mu.nombre = c_municipio_nombre;

END $$

DELIMITER ;

CALL ps_obtener_clientes_por_municipio('Cali');

-- 3. Cree un procedimiento por nombre  `ps_listar_empleados_por_sucursal` donde muestre todos los empleados de una sucursal .

DELIMITER $$

DROP PROCEDURE IF EXISTS ps_listar_empleados_por_sucursal $$

CREATE PROCEDURE ps_listar_empleados_por_sucursal(
    IN c_sucursal_nombre VARCHAR(80)
)
BEGIN
    SELECT
        em.nombre,
        em.puesto,
        em.salario
    FROM empleados em
    JOIN sucursal su ON em.sucursal_id = su.id
    WHERE su.nombre = c_sucursal_nombre;

END $$

DELIMITER ;

CALL ps_listar_empleados_por_sucursal('Sucursal Zona 3');