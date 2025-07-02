-- Active: 1751458388058@@127.0.0.1@3307@examen_mysql
-- MySQL dump 10.13  Distrib 8.4.3, for Linux (aarch64)
--
-- Host: localhost    Database: examen
-- ------------------------------------------------------
-- Server version	8.4.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */
/*!50503 SET NAMES utf8mb4 */
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */
/*!40103 SET TIME_ZONE='+00:00' */
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */

-- Database

CREATE DATABASE examen_mysql DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE examen_mysql;

SHOW TABLES;

-- Drops for each table

DROP TABLE IF EXISTS detalles_pedidos;

DROP TABLE IF EXISTS pedidos;

DROP TABLE IF EXISTS producto_suc;

DROP TABLE IF EXISTS productos;

DROP TABLE IF EXISTS clientes;

DROP TABLE IF EXISTS empleados;

DROP TABLE IF EXISTS sucursal;

DROP TABLE IF EXISTS empresa;

DROP TABLE IF EXISTS municipio;

DROP TABLE IF EXISTS departamento;

DROP TABLE IF EXISTS pais;

-- Tables

CREATE TABLE `pais` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE `departamento` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(80) NOT NULL,
  `pais_id` INT NOT NULL
);

CREATE TABLE `municipio` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(80) NOT NULL,
  `departamento_id` INT NOT NULL
);

CREATE TABLE `empresa` (
  `id` VARCHAR(20) NOT NULL PRIMARY KEY,
  `nombre` VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE `sucursal` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(80) NOT NULL,
  `direccion` VARCHAR(80) NOT NULL,
  `empresa_id` VARCHAR(20) NOT NULL,
  `municipio_id` INT NOT NULL
);

CREATE TABLE `empleados` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(80) NOT NULL UNIQUE,
  `puesto` VARCHAR(50) NOT NULL,
  `fecha_contratacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `salario` DECIMAL(10,2) NOT NULL,
  `sucursal_id` INT NOT NULL
);

CREATE TABLE `clientes` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(80) NOT NULL,
  `email` VARCHAR(50) NOT NULL UNIQUE,
  `telefono` VARCHAR(15) NOT NULL UNIQUE,
  `direccion` VARCHAR(50) NOT NULL,
  `fecha_registro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `municipio_id` INT NOT NULL
);

CREATE TABLE `productos` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(80) DEFAULT NULL,
  `categoria` VARCHAR(80) DEFAULT NULL,
  `precio` DECIMAL(10,2) DEFAULT NULL,
  `stock` INT DEFAULT NULL
);

CREATE TABLE `producto_suc` (
  `producto_id` INT NOT NULL,
  `sucursal_id` INT NOT NULL,
  PRIMARY KEY (`producto_id`,`sucursal_id`)
);

CREATE TABLE `pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `cliente_id` INT NOT NULL,
  `empleado_id` INT NOT NULL,
  `fecha_pedido` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` VARCHAR(20) NOT NULL
);

CREATE TABLE `detalles_pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `pedido_id` INT NOT NULL,
  `producto_id` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precio_unitario` DECIMAL(10,2) NOT NULL,
  `sucursal_id` INT NOT NULL
);

-- Foreign Keys

ALTER TABLE clientes ADD CONSTRAINT clientes_municipio_id 
FOREIGN KEY (municipio_id) REFERENCES municipio (id);

ALTER TABLE departamento ADD CONSTRAINT departamento_pais_id
FOREIGN KEY (pais_id) REFERENCES pais (id);

ALTER TABLE detalles_pedidos ADD CONSTRAINT detalles_pedidos_pedido_id
FOREIGN KEY (pedido_id) REFERENCES pedidos (id);

ALTER TABLE detalles_pedidos ADD CONSTRAINT detalles_pedidos_producto_id
FOREIGN KEY (producto_id) REFERENCES productos (id);

ALTER TABLE detalles_pedidos ADD CONSTRAINT detalles_pedidos_sucursal_id
FOREIGN KEY (sucursal_id) REFERENCES sucursal (id);

ALTER TABLE empleados ADD CONSTRAINT empleados_sucursal_id
FOREIGN KEY (sucursal_id) REFERENCES sucursal (id);

ALTER TABLE municipio ADD CONSTRAINT municipio_departamento_id
FOREIGN KEY (departamento_id) REFERENCES departamento (id);

ALTER TABLE pedidos ADD CONSTRAINT pedidos_cliente_id
FOREIGN KEY (cliente_id) REFERENCES clientes (id);

ALTER TABLE pedidos ADD CONSTRAINT pedidos_empleado_id
FOREIGN KEY (empleado_id) REFERENCES empleados (id);

ALTER TABLE producto_suc ADD CONSTRAINT producto_suc_producto_id
FOREIGN KEY (producto_id) REFERENCES productos (id);

ALTER TABLE producto_suc ADD CONSTRAINT producto_suc_sucursal_id
FOREIGN KEY (sucursal_id) REFERENCES sucursal (id);

ALTER TABLE sucursal ADD CONSTRAINT sucursal_empresa_id
FOREIGN KEY (empresa_id) REFERENCES empresa (id);

ALTER TABLE sucursal ADD CONSTRAINT sucursal_municipio_id
FOREIGN KEY (municipio_id) REFERENCES municipio (id);

--
/*!40101 SET @saved_cs_client     = @@character_set_client */
/*!50503 SET character_set_client = utf8mb4 */

/*!40101 SET character_set_client = @saved_cs_client */

--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */
UNLOCK TABLES;

--

/*!40101 SET @saved_cs_client     = @@character_set_client */
/*!50503 SET character_set_client = utf8mb4 */

/*!40101 SET character_set_client = @saved_cs_client */

--
-- Dumping data for table `departamento`
--

LOCK TABLES `departamento` WRITE;
/*!40000 ALTER TABLE `departamento` DISABLE KEYS */
/*!40000 ALTER TABLE `departamento` ENABLE KEYS */
UNLOCK TABLES;

--

/*!40101 SET @saved_cs_client     = @@character_set_client */
/*!50503 SET character_set_client = utf8mb4 */

/*!40101 SET character_set_client = @saved_cs_client */

--
-- Dumping data for table `detalles_pedidos`
--

LOCK TABLES `detalles_pedidos` WRITE;
/*!40000 ALTER TABLE `detalles_pedidos` DISABLE KEYS */
/*!40000 ALTER TABLE `detalles_pedidos` ENABLE KEYS */
UNLOCK TABLES;

--

/*!40101 SET @saved_cs_client     = @@character_set_client */
/*!50503 SET character_set_client = utf8mb4 */

/*!40101 SET character_set_client = @saved_cs_client */

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */
UNLOCK TABLES;

--

/*!40101 SET @saved_cs_client     = @@character_set_client */
/*!50503 SET character_set_client = utf8mb4 */


/*!40101 SET character_set_client = @saved_cs_client */

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */
UNLOCK TABLES;

--

/*!40101 SET @saved_cs_client     = @@character_set_client */
/*!50503 SET character_set_client = utf8mb4 */

/*!40101 SET character_set_client = @saved_cs_client */

--
-- Dumping data for table `municipio`
--

LOCK TABLES `municipio` WRITE;
/*!40000 ALTER TABLE `municipio` DISABLE KEYS */
/*!40000 ALTER TABLE `municipio` ENABLE KEYS */
UNLOCK TABLES;

--

/*!40101 SET @saved_cs_client     = @@character_set_client */
/*!50503 SET character_set_client = utf8mb4 */

/*!40101 SET character_set_client = @saved_cs_client */

--
-- Dumping data for table `pais`
--

LOCK TABLES `pais` WRITE;
/*!40000 ALTER TABLE `pais` DISABLE KEYS */
/*!40000 ALTER TABLE `pais` ENABLE KEYS */
UNLOCK TABLES;

--

/*!40101 SET @saved_cs_client     = @@character_set_client */
/*!50503 SET character_set_client = utf8mb4 */

/*!40101 SET character_set_client = @saved_cs_client */

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */
UNLOCK TABLES;

--

/*!40101 SET @saved_cs_client     = @@character_set_client */
/*!50503 SET character_set_client = utf8mb4 */

/*!40101 SET character_set_client = @saved_cs_client */

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */
/*!40000 ALTER TABLE `productos` ENABLE KEYS */
UNLOCK TABLES;

--

/*!40101 SET @saved_cs_client     = @@character_set_client */
/*!50503 SET character_set_client = utf8mb4 */

/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto_suc`
--

LOCK TABLES `producto_suc` WRITE;
/*!40000 ALTER TABLE `producto_suc` DISABLE KEYS */
/*!40000 ALTER TABLE `producto_suc` ENABLE KEYS */
UNLOCK TABLES;

--
--
/*!40101 SET @saved_cs_client     = @@character_set_client */
/*!50503 SET character_set_client = utf8mb4 */

/*!40101 SET character_set_client = @saved_cs_client */

--

LOCK TABLES `sucursal` WRITE;
/*!40000 ALTER TABLE `sucursal` DISABLE KEYS */
/*!40000 ALTER TABLE `sucursal` ENABLE KEYS */
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */

-- Dump completed on 2025-07-02  2:57:26
