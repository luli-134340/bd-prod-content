-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dev
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dev
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dev` DEFAULT CHARACTER SET utf8 ;
USE `dev` ;

-- -----------------------------------------------------
-- Table `dev`.`EstadosProduccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dev`.`EstadosProduccion` (
  `id_estado` INT NOT NULL AUTO_INCREMENT,
  `nombre_esatado` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_estado`),
  UNIQUE INDEX `id_estado_UNIQUE` (`id_estado` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`EquiposProduccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dev`.`EquiposProduccion` (
  `id_equipo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NOT NULL,
  `rol` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_equipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`Contenidos_EquipoProd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dev`.`Contenidos_EquipoProd` (
  `id_equipo` INT NOT NULL,
  PRIMARY KEY (`id_equipo`),
  CONSTRAINT `fk_Contenidos_EquipoProd_EquipoProduccion1`
    FOREIGN KEY (`id_equipo`)
    REFERENCES `dev`.`EquiposProduccion` (`id_equipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`Contenidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dev`.`Contenidos` (
  `id_contenido` INT NOT NULL AUTO_INCREMENT,
  `titulo:` VARCHAR(255) NOT NULL,
  `sinopsis:` TEXT NULL,
  `genero` VARCHAR(100) NULL,
  `fecha_creacion` DATE NULL,
  `idioma` VARCHAR(50) NULL,
  `formato` VARCHAR(50) NULL,
  `palabras_clave` TEXT NULL,
  `estado_actual_id` INT NULL,
  `id_equipo` INT NOT NULL,
  PRIMARY KEY (`id_contenido`, `id_equipo`),
  UNIQUE INDEX `titulo:_UNIQUE` (`titulo:` ASC) VISIBLE,
  INDEX `fk_Contenido_EstadoProduccion1_idx` (`estado_actual_id` ASC) VISIBLE,
  INDEX `fk_Contenido_Contenidos_EquipoProd1_idx` (`id_equipo` ASC) VISIBLE,
  UNIQUE INDEX `id_contenido_UNIQUE` (`id_contenido` ASC) VISIBLE,
  CONSTRAINT `fk_Contenido_EstadoProduccion1`
    FOREIGN KEY (`estado_actual_id`)
    REFERENCES `dev`.`EstadosProduccion` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contenido_Contenidos_EquipoProd1`
    FOREIGN KEY (`id_equipo`)
    REFERENCES `dev`.`Contenidos_EquipoProd` (`id_equipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`EstadisticasContenido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dev`.`EstadisticasContenido` (
  `id_estadistica` INT NOT NULL AUTO_INCREMENT,
  `numero_visualizaciones` INT NULL,
  `puntuacion_promedio` DECIMAL(2) NULL,
  `frecuencia_aparicion` INT NULL,
  `tasa_finalizacion` DECIMAL(2) NULL,
  `duracion_promedio` DECIMAL(2) NULL,
  `fecha_estadistica` DATE NULL,
  `id_contenido` INT NOT NULL,
  PRIMARY KEY (`id_estadistica`, `id_contenido`),
  INDEX `fk_EstadisticasContenido_Contenido1_idx` (`id_contenido` ASC) VISIBLE,
  UNIQUE INDEX `id_estadistica_UNIQUE` (`id_estadistica` ASC) VISIBLE,
  CONSTRAINT `fk_EstadisticasContenido_Contenido1`
    FOREIGN KEY (`id_contenido`)
    REFERENCES `dev`.`Contenidos` (`id_contenido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`Notificaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dev`.`Notificaciones` (
  `id_notificacion` INT NOT NULL AUTO_INCREMENT,
  `mensaje` TEXT NULL,
  `fecha_notificacion` DATETIME NULL,
  `id_contenido` INT NOT NULL,
  PRIMARY KEY (`id_notificacion`, `id_contenido`),
  INDEX `fk_Notificaciones_Contenido1_idx` (`id_contenido` ASC) VISIBLE,
  UNIQUE INDEX `id_notificacion_UNIQUE` (`id_notificacion` ASC) VISIBLE,
  CONSTRAINT `fk_Notificaciones_Contenido1`
    FOREIGN KEY (`id_contenido`)
    REFERENCES `dev`.`Contenidos` (`id_contenido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dev`.`Roles` (
  `id_rol` INT NOT NULL AUTO_INCREMENT,
  `nombre_rol` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE INDEX `id_rol_UNIQUE` (`id_rol` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dev`.`Usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `contraseña` VARCHAR(100) NOT NULL,
  `id_rol` INT NOT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX `fk_Usuario_Rol1_idx` (`id_rol` ASC) VISIBLE,
  UNIQUE INDEX `id_usuario_UNIQUE` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_Rol1`
    FOREIGN KEY (`id_rol`)
    REFERENCES `dev`.`Roles` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`HistorialCambios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dev`.`HistorialCambios` (
  `id_cambio` INT NOT NULL AUTO_INCREMENT,
  `fecha_cambio` DATETIME NULL,
  `campo_modificado` VARCHAR(100) NULL,
  `valor_anterior` TEXT NULL,
  `valor_nuevo` TEXT NULL,
  `id_usuario` INT NOT NULL,
  `id_contenido` INT NOT NULL,
  PRIMARY KEY (`id_cambio`, `id_contenido`, `id_usuario`),
  INDEX `fk_HistorialCambios_Usuario1_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_HistorialCambios_Contenido1_idx` (`id_contenido` ASC) VISIBLE,
  CONSTRAINT `fk_HistorialCambios_Usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `dev`.`Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HistorialCambios_Contenido1`
    FOREIGN KEY (`id_contenido`)
    REFERENCES `dev`.`Contenidos` (`id_contenido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`PalabrasClave`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dev`.`PalabrasClave` (
  `id_palabraclave` INT NOT NULL AUTO_INCREMENT,
  `palabra_clave` TEXT NULL,
  `id_contenido` INT NOT NULL,
  PRIMARY KEY (`id_palabraclave`),
  INDEX `fk_PalabrasClave_Contenido1_idx` (`id_contenido` ASC) VISIBLE,
  CONSTRAINT `fk_PalabrasClave_Contenido1`
    FOREIGN KEY (`id_contenido`)
    REFERENCES `dev`.`Contenidos` (`id_contenido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
