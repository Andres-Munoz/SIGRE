-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema SIGRE
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SIGRE
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SIGRE` DEFAULT CHARACTER SET latin1 ;
USE `SIGRE` ;

-- -----------------------------------------------------
-- Table `SIGRE`.`ambiente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIGRE`.`ambiente` (
  `id_ambiente` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `capacidad` INT(11) NOT NULL,
  `Equipos` VARCHAR(2) NOT NULL,
  `Descripcion` VARCHAR(300) NULL DEFAULT NULL,
  PRIMARY KEY (`id_ambiente`))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SIGRE`.`centro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIGRE`.`centro` (
  `id_centro` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `ubicacion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_centro`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SIGRE`.`equipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIGRE`.`equipo` (
  `id_equipo` INT(11) NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  `ambiente_id_ambiente` INT(11) NOT NULL,
  PRIMARY KEY (`id_equipo`),
  UNIQUE INDEX `codigo` (`codigo` ASC),
  INDEX `ambiente_id_ambiente` (`ambiente_id_ambiente` ASC),
  CONSTRAINT `equipo_ibfk_1`
    FOREIGN KEY (`ambiente_id_ambiente`)
    REFERENCES `SIGRE`.`ambiente` (`id_ambiente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SIGRE`.`programa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIGRE`.`programa` (
  `id_programa` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `tipo_programa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_programa`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SIGRE`.`ficha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIGRE`.`ficha` (
  `id_ficha` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_fin` TIME NOT NULL,
  `nombre_ficha` VARCHAR(45) NOT NULL,
  `programa_id_programa` INT(11) NOT NULL,
  PRIMARY KEY (`id_ficha`),
  INDEX `programa_id_programa` (`programa_id_programa` ASC),
  CONSTRAINT `ficha_ibfk_1`
    FOREIGN KEY (`programa_id_programa`)
    REFERENCES `SIGRE`.`programa` (`id_programa`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SIGRE`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIGRE`.`usuario` (
  `idusuario` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_completo` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(500) NOT NULL,
  `rol` VARCHAR(45) NOT NULL,
  `activo` INT(11) NOT NULL DEFAULT '1',
  `ultimo_acceso` DATETIME NULL DEFAULT NULL,
  `cod_activacion` VARCHAR(45) NULL DEFAULT NULL,
  `imagen` LONGBLOB NULL DEFAULT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE INDEX `username` (`username` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SIGRE`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIGRE`.`persona` (
  `persona_idusuario` INT(11) NOT NULL,
  `documento` VARCHAR(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `centro_id_centro` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`persona_idusuario`),
  UNIQUE INDEX `documento_UNIQUE` (`documento` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `fk_Persona_usuario1_idx` (`persona_idusuario` ASC),
  INDEX `fk_persona_centro1_idx` (`centro_id_centro` ASC),
  CONSTRAINT `fk_Persona_usuario1`
    FOREIGN KEY (`persona_idusuario`)
    REFERENCES `SIGRE`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_persona_centro1`
    FOREIGN KEY (`centro_id_centro`)
    REFERENCES `SIGRE`.`centro` (`id_centro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SIGRE`.`horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIGRE`.`horario` (
  `id_horario` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NOT NULL,
  `dia` VARCHAR(45) NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_fin` TIME NOT NULL,
  `ambiente_id_ambiente` INT(11) NOT NULL,
  `persona_idusuario` INT(11) NOT NULL,
  `ficha_id_ficha` INT(11) NOT NULL,
  PRIMARY KEY (`id_horario`, `ambiente_id_ambiente`, `persona_idusuario`, `ficha_id_ficha`),
  INDEX `fk_horario_ambiente1_idx` (`ambiente_id_ambiente` ASC),
  INDEX `fk_horario_persona1_idx` (`persona_idusuario` ASC),
  INDEX `fk_horario_ficha1_idx` (`ficha_id_ficha` ASC),
  CONSTRAINT `fk_horario_ambiente1`
    FOREIGN KEY (`ambiente_id_ambiente`)
    REFERENCES `SIGRE`.`ambiente` (`id_ambiente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_horario_ficha1`
    FOREIGN KEY (`ficha_id_ficha`)
    REFERENCES `SIGRE`.`ficha` (`id_ficha`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_horario_persona1`
    FOREIGN KEY (`persona_idusuario`)
    REFERENCES `SIGRE`.`persona` (`persona_idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SIGRE`.`matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIGRE`.`matricula` (
  `id_matricula` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `persona_idusuario` INT(11) NOT NULL,
  `ficha_id_ficha` INT(11) NOT NULL,
  PRIMARY KEY (`id_matricula`, `persona_idusuario`, `ficha_id_ficha`),
  INDEX `fk_Matricula_persona1_idx` (`persona_idusuario` ASC),
  INDEX `fk_matricula_ficha1_idx` (`ficha_id_ficha` ASC),
  CONSTRAINT `fk_Matricula_persona1`
    FOREIGN KEY (`persona_idusuario`)
    REFERENCES `SIGRE`.`persona` (`persona_idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_matricula_ficha1`
    FOREIGN KEY (`ficha_id_ficha`)
    REFERENCES `SIGRE`.`ficha` (`id_ficha`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SIGRE`.`modulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIGRE`.`modulo` (
  `idmodulo` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `activo` INT(11) NOT NULL DEFAULT '1',
  `url` VARCHAR(50) NULL DEFAULT NULL,
  `icono` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idmodulo`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SIGRE`.`modulo_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIGRE`.`modulo_usuario` (
  `id_modulo` INT(11) NOT NULL,
  `id_usuario` INT(11) NOT NULL,
  PRIMARY KEY (`id_modulo`, `id_usuario`),
  INDEX `fk_modulo_has_usuario_usuario1_idx` (`id_usuario` ASC),
  INDEX `fk_modulo_has_usuario_modulo_idx` (`id_modulo` ASC),
  CONSTRAINT `fk_modulo_has_usuario_modulo`
    FOREIGN KEY (`id_modulo`)
    REFERENCES `SIGRE`.`modulo` (`idmodulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_modulo_has_usuario_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `SIGRE`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SIGRE`.`peticion_equipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIGRE`.`peticion_equipo` (
  `id_peticion_equipo` INT(11) NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(45) NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_fin` TIME NOT NULL,
  `fecha` DATE NOT NULL,
  `equipo_id_equipo` INT(11) NOT NULL,
  `persona_idusuario` INT(11) NOT NULL,
  PRIMARY KEY (`id_peticion_equipo`, `equipo_id_equipo`, `persona_idusuario`),
  INDEX `fk_peticion_equipo_equipo1_idx` (`equipo_id_equipo` ASC),
  INDEX `fk_peticion_equipo_persona1_idx` (`persona_idusuario` ASC),
  CONSTRAINT `fk_peticion_equipo_equipo1`
    FOREIGN KEY (`equipo_id_equipo`)
    REFERENCES `SIGRE`.`equipo` (`id_equipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_peticion_equipo_persona1`
    FOREIGN KEY (`persona_idusuario`)
    REFERENCES `SIGRE`.`persona` (`persona_idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SIGRE`.`reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIGRE`.`reserva` (
  `id_reserva` INT(11) NOT NULL AUTO_INCREMENT,
  `hora_inicio` TIME NOT NULL,
  `hora_fin` TIME NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NOT NULL,
  `estado` INT(1) NULL DEFAULT '1',
  `persona_idusuario` INT(11) NULL DEFAULT NULL,
  `ambiente_id_ambiente` INT(11) NULL DEFAULT NULL,
  `ficha_id_ficha` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_reserva`),
  INDEX `fk_Reserva_persona1_idx` (`persona_idusuario` ASC),
  INDEX `fk_Reserva_Ambiente1_idx` (`ambiente_id_ambiente` ASC),
  INDEX `fk_reserva_ficha1_idx` (`ficha_id_ficha` ASC),
  CONSTRAINT `fk_Reserva_Ambiente1`
    FOREIGN KEY (`ambiente_id_ambiente`)
    REFERENCES `SIGRE`.`ambiente` (`id_ambiente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_persona1`
    FOREIGN KEY (`persona_idusuario`)
    REFERENCES `SIGRE`.`persona` (`persona_idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_ficha1`
    FOREIGN KEY (`ficha_id_ficha`)
    REFERENCES `SIGRE`.`ficha` (`id_ficha`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 20
DEFAULT CHARACTER SET = utf8;


INSERT INTO modulo VALUES (1,'Ambientes','Informacion de ambientes',1,'/views/sena/ambientes.xhtml',''),(2,'Fichas','Informacion sobre las fichas',1,'/views/sena/fichas.xhtml',''),(3,'Programas','Informacion sobre los programas',1,'/views/sena/programas.xhtml',''),(4,'Reservas','Informacion de las reservas',1,'/views/sena/reservas.xhtml','');

INSERT INTO usuario VALUES (1,'Admin Principal','ADMIN','523b1abfa5723cf5eab483c04d35984bd8b8e4366f6c58dce28e87ddd1baae56ae56de4ea483a8e4e9e04093cedd266d9d0916eafc84328c053abd1d41f7f14b','ADMIN',1,'2018-11-13 08:38:38','rOW1WZtk8q1UHqwOl',null);

INSERT INTO modulo_usuario VALUES (1,1),(2,1),(3,1),(4,1);

INSERT INTO `centro` (`id_centro`, `nombre`, `ubicacion`) VALUES
(1, 'Agropecuario', 'Santander de Quilichao'),
(2, 'Tele-informatica y producción industrial', 'Santander de Quilichao'),
(3, 'Comercio y servicios', 'Santander de Quilichao'),(4, 'No aplica', 'Santander de Quilichao');

INSERT INTO `persona` (`persona_idusuario`, `documento`, `nombre`, `apellido`, `telefono`, `email`, `centro_id_centro`) VALUES
(1, '100000000', 'Admin', 'Principal', '3000000000', 'admin@admin.com', 4 );

INSERT INTO `ambiente` (`id_ambiente`, `nombre`, `tipo`, `capacidad`, `Equipos`, `Descripcion`) VALUES
(1, 'Ambiente-01', 'CONVENCIONAL', 30, 'SI', ''),
(2, 'Ambiente-02', 'CONVENCIONAL', 30, 'SI', NULL),
(3, 'Ambiente-03', 'TEORICO-PRACTICO', 30, 'SI', NULL),
(4, 'Ambinete-04', 'TEORICO-PRACTICO', 30, 'SI', NULL),
(5, 'Ambiente-05', 'TEORICO-PRACTICO', 30, 'SI', NULL),
(6, 'Ambiente-06', 'CONVENCIONAL', 30, 'SI', NULL),
(7, 'Ambiente-07', 'CONVENCIONAL', 30, 'SI', NULL),
(8, 'Ambiente-08', 'CONVENCIONAL', 30, 'SI', NULL),
(9, 'Ambiente-09', 'CONVENCIONAL', 30, 'SI', NULL),
(10, 'Ambiente-10', 'CONVENCIONAL', 30, 'SI', NULL),
(11, 'Quiosco-01', 'CONVENCIONAL', 30, 'NO', NULL),
(12, 'Quiosco-02', 'CONVENCIONAL', 30, 'NO', NULL),
(13, 'Quiosco-03', 'CONVENCIONAL', 30, 'NO', NULL),
(14, 'Auditorio-01', 'CONVENCIONAL', 30, 'SI', NULL),
(15, 'Auditorio-02', 'CONVENCIONAL', 30, 'SI', NULL),
(16, 'Audito-completo', 'CONVENCIONAL', 60, 'SI', NULL);

INSERT INTO `programa` (`id_programa`, `nombre`, `tipo_programa`) VALUES
(2, 'Análisis y desarrollo de sistemas de información', 'Tecnología'),
(6, 'Mecanico maquinaria industrial', 'Técnico'),
(7, 'Entrenamiento deportivo', 'Tecnología'),
(8, 'Sistemas de gestión ambiental', 'Tecnología'),
(9, 'Soldadura de productos metálicos', 'Técnico'),
(10, 'Alistamiento y operación de maquinaria para la producción industrial', 'Técnico'),
(11, 'Sistemas', 'Técnico'),
(12, 'Recursos humanos', 'Tecnología'),
(13, 'Mecánica rural', 'Técnico'),
(15, 'Gestión de procesos administrativos en salud', 'Tecnología'),
(16, 'Gestión administrativa', 'Tecnología'),
(17, 'Gestión empresarial', 'Tecnología'),
(18, 'Salud publica', 'Técnico'),
(19, 'Asistencia administrativa', 'Técnico'),
(20, 'Asistencia integral a la primera infancia ', 'Técnico'),
(21, 'Cocina', 'Técnico'),
(22, 'Logística empresarial', 'Técnico'),
(23, 'Biocomercio sostenible', 'Tecnología');

INSERT INTO `ficha` (`id_ficha`, `fecha_inicio`, `fecha_fin`, `hora_inicio`, `hora_fin`, `nombre_ficha`, `programa_id_programa`) VALUES
(1, '2017-07-17', '2019-07-17', '13:00:00', '19:00:00', '1438256', 2),
(2, '2018-04-16', '2019-07-15', '13:00:00', '19:00:00', '1616684', 6),
(3, '2018-07-16', '2020-07-16', '19:00:00', '22:00:00', '1694921', 7),
(4, '2018-07-16', '2020-07-16', '07:00:00', '13:00:00', '1696274', 8),
(5, '2018-07-16', '2019-10-16', '13:00:00', '19:00:00', '1695025', 9),
(6, '2018-07-16', '2019-07-16', '13:00:00', '19:00:00', '1696261', 10),
(7, '2018-07-16', '2019-07-16', '18:00:00', '22:00:00', '1696055', 11),
(8, '2017-07-17', '2019-07-16', '07:00:00', '13:00:00', '1446749', 12),
(9, '2018-07-16', '2020-07-15', '13:00:00', '19:00:00', '1692796', 23),
(10, '2018-07-16', '2019-07-15', '13:00:00', '19:00:00', '1697761', 13),
(11, '2018-10-01', '2019-09-30', '13:00:00', '19:00:00', '1755860', 12),
(12, '2017-09-25', '2019-09-24', '13:00:00', '18:00:00', '1507301', 15),
(13, '2017-09-24', '2019-09-25', '07:00:00', '13:00:00', '1502646', 16),
(14, '2017-12-11', '2019-12-11', '13:00:00', '18:00:00', '1589478', 17),
(15, '2018-04-16', '2019-10-15', '18:00:00', '22:00:00', '1613392', 18),
(16, '2018-07-16', '2019-07-15', '07:00:00', '13:00:00', '1694858', 19),
(17, '2018-07-16', '2019-12-15', '07:00:00', '13:00:00', '1696060', 20),
(18, '2018-07-16', '2019-12-15', '07:00:00', '13:00:00', '1694776', 21),
(19, '2018-07-16', '2019-07-15', '07:00:00', '13:00:00', '1694813', 22);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

