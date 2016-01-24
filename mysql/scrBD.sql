-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema actividad
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema actividad
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `actividad` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `actividad` ;

-- -----------------------------------------------------
-- Table `actividad`.`PARTICIPANTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `actividad`.`PARTICIPANTE` (
  `idPARTICIPANTE` INT NOT NULL COMMENT '',
  `nombre` VARCHAR(12) NULL COMMENT '',
  `apellido` VARCHAR(18) NULL COMMENT '',
  `nacionalidad` VARCHAR(18) NULL COMMENT '',
  `especialidad` VARCHAR(18) NULL COMMENT '',
  `esponente` TINYINT(1) NULL COMMENT '',
  PRIMARY KEY (`idPARTICIPANTE`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `actividad`.`OYENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `actividad`.`OYENTE` (
  `idPARTICIPANTE` INT NOT NULL COMMENT '',
  `nombre` VARCHAR(45) NULL COMMENT '',
  `apellido` VARCHAR(45) NULL COMMENT '',
  `ponencia-asignada` VARCHAR(45) NULL COMMENT '',
  `PARTICIPANTE_idPARTICIPANTE` INT NOT NULL COMMENT '',
  PRIMARY KEY (`idPARTICIPANTE`)  COMMENT '',
  INDEX `fk_OYENTE_PARTICIPANTE_idx` (`PARTICIPANTE_idPARTICIPANTE` ASC)  COMMENT '',
  CONSTRAINT `fk_OYENTE_PARTICIPANTE`
    FOREIGN KEY (`PARTICIPANTE_idPARTICIPANTE`)
    REFERENCES `actividad`.`PARTICIPANTE` (`idPARTICIPANTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `actividad`.`PONENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `actividad`.`PONENTE` (
  `idPARTICIPANTE` INT NOT NULL COMMENT '',
  `nombre` VARCHAR(18) NULL COMMENT '',
  `apellido` VARCHAR(18) NULL COMMENT '',
  `ponencia-asignada` VARCHAR(20) NULL COMMENT '',
  `PARTICIPANTE_idPARTICIPANTE` INT NOT NULL COMMENT '',
  PRIMARY KEY (`idPARTICIPANTE`)  COMMENT '',
  INDEX `fk_PONENTE_PARTICIPANTE1_idx` (`PARTICIPANTE_idPARTICIPANTE` ASC)  COMMENT '',
  CONSTRAINT `fk_PONENTE_PARTICIPANTE1`
    FOREIGN KEY (`PARTICIPANTE_idPARTICIPANTE`)
    REFERENCES `actividad`.`PARTICIPANTE` (`idPARTICIPANTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `actividad`.`PONENCIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `actividad`.`PONENCIA` (
  `ponencia-asignada` VARCHAR(20) NOT NULL COMMENT '',
  `idPARTICIPANTE-PONENTE` INT(15) NULL COMMENT '',
  `oyentes` VARCHAR(45) NULL COMMENT '',
  `PONENTE_idPARTICIPANTE` INT NOT NULL COMMENT '',
  PRIMARY KEY (`ponencia-asignada`)  COMMENT '',
  INDEX `fk_PONENCIA_PONENTE1_idx` (`PONENTE_idPARTICIPANTE` ASC)  COMMENT '',
  CONSTRAINT `fk_PONENCIA_PONENTE1`
    FOREIGN KEY (`PONENTE_idPARTICIPANTE`)
    REFERENCES `actividad`.`PONENTE` (`idPARTICIPANTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `actividad` ;

-- -----------------------------------------------------
-- Placeholder table for view `actividad`.`arquitectosyurbanistas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `actividad`.`arquitectosyurbanistas` (`nombre` INT);

-- -----------------------------------------------------
-- Placeholder table for view `actividad`.`veroyentes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `actividad`.`veroyentes` (`id` INT);

-- -----------------------------------------------------
-- procedure esextranjero
-- -----------------------------------------------------

DELIMITER $$
USE `actividad`$$
CREATE PROCEDURE `esextranjero` (IN booleano INT)
BEGIN
UPDATE PARTICIPANTE SET nacionalidad='extranjero'
WHERE nacionalidad=Null;
END
$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sinapellido
-- -----------------------------------------------------

DELIMITER $$
USE `actividad`$$
CREATE PROCEDURE `sinapellido` (IN cambia INT)
BEGIN
UPDATE PARTICIPANTE SET apellido='sin apellido' 
WHERE apellido=Null;
END
$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure copiallave
-- -----------------------------------------------------

DELIMITER $$
USE `actividad`$$
CREATE PROCEDURE `copiallave` (IN copia INT)
BEGIN
INSERT INTO OYENTE
SELECT idPARTICIPANTE FROM PARTICIPANTE;
END
$$

DELIMITER ;

-- -----------------------------------------------------
-- View `actividad`.`arquitectosyurbanistas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `actividad`.`arquitectosyurbanistas`;
USE `actividad`;
CREATE  OR REPLACE VIEW `arquitectosyurbanistas` AS
SELECT nombre FROM PONENTES
WHERE especialidad='arquitectura' OR especialidad='urbanismo';

-- -----------------------------------------------------
-- View `actividad`.`veroyentes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `actividad`.`veroyentes`;
USE `actividad`;
CREATE  OR REPLACE VIEW `veroyentes` AS
SELECT * FROM OYENTES WHERE
PARTICIPANTES.esponente= False;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Trigger `copiaparticipantes` AFTER INSERT ON PARTICIPANTE
-- -----------------------------------------------------

DELIMITER $$
FOR EACH ROW
BEGIN
INSERT INTO OYENTES
SELECT idPARTICIPANTE, nombre, apellido, FROM PARTICIPANTE;
END
$$

DELIMITER ; 

-- -----------------------------------------------------
-- Trigger `copiaponente` AFTER INSERT ON PARTICIPANTE
-- -----------------------------------------------------

DELIMITER $$
FOR EACH ROW
BEGIN
IF esponente.PARTICIPANTE=True
INSERT INTO PONENTES
SELECT idPARTICIPANTE, nombre, apellido, FROM PARTICIPANTE;
END
$$

DELIMITER ;