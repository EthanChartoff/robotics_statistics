-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema robotics
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `robotics` ;

-- -----------------------------------------------------
-- Schema robotics
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `robotics` ;
USE `robotics` ;

-- -----------------------------------------------------
-- Table `robotics`.`Countries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `robotics`.`Countries` ;

CREATE TABLE IF NOT EXISTS `robotics`.`Countries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `robotics`.`Districts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `robotics`.`Districts` ;

CREATE TABLE IF NOT EXISTS `robotics`.`Districts` (
  `id` INT NOT NULL,
  `Countries_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `Countries_id`),
  INDEX `fk_Districts_Countries1_idx` (`Countries_id` ASC),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  CONSTRAINT `fk_Districts_Countries1`
    FOREIGN KEY (`Countries_id`)
    REFERENCES `robotics`.`Countries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `robotics`.`Cities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `robotics`.`Cities` ;

CREATE TABLE IF NOT EXISTS `robotics`.`Cities` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Districts_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `Districts_id`),
  INDEX `fk_Cities_Districts1_idx` (`Districts_id` ASC),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  CONSTRAINT `fk_Cities_Districts1`
    FOREIGN KEY (`Districts_id`)
    REFERENCES `robotics`.`Districts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `robotics`.`Teams`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `robotics`.`Teams` ;

CREATE TABLE IF NOT EXISTS `robotics`.`Teams` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Cities_id` INT UNSIGNED NOT NULL,
  `address` VARCHAR(100) NULL,
  `name` VARCHAR(200) NOT NULL,
  `nickname` VARCHAR(45) NULL,
  `rookie_year` YEAR NULL,
  `team_number` SMALLINT UNSIGNED NOT NULL,
  `website` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_Teams_Cities1_idx` (`Cities_id` ASC),
  CONSTRAINT `fk_Teams_Cities1`
    FOREIGN KEY (`Cities_id`)
    REFERENCES `robotics`.`Cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `robotics`.`Competitions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `robotics`.`Competitions` ;

CREATE TABLE IF NOT EXISTS `robotics`.`Competitions` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Cities_id` INT UNSIGNED NOT NULL,
  `Cities_Districts_id` INT NOT NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `name` VARCHAR(45) NULL,
  `website` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Competitions_Cities1_idx` (`Cities_id` ASC, `Cities_Districts_id` ASC),
  CONSTRAINT `fk_Competitions_Cities1`
    FOREIGN KEY (`Cities_id` , `Cities_Districts_id`)
    REFERENCES `robotics`.`Cities` (`id` , `Districts_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `robotics`.`Match_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `robotics`.`Match_Type` ;

CREATE TABLE IF NOT EXISTS `robotics`.`Match_Type` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `type_UNIQUE` (`type` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `robotics`.`Matches`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `robotics`.`Matches` ;

CREATE TABLE IF NOT EXISTS `robotics`.`Matches` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Competitions_id` INT UNSIGNED NOT NULL,
  `Match_Type_id` INT UNSIGNED NOT NULL,
  `group1_score` SMALLINT NOT NULL,
  `group2_score` SMALLINT NOT NULL,
  `group_won` TINYINT NOT NULL,
  `match_number` SMALLINT UNSIGNED NULL,
  `start_datetime` DATETIME NULL,
  `end_datetime` DATETIME NULL,
  `group1_rp` TINYINT NOT NULL,
  `group2_rp` TINYINT NOT NULL,
  PRIMARY KEY (`id`, `Competitions_id`, `Match_Type_id`),
  INDEX `fk_Matches_Competitions1_idx` (`Competitions_id` ASC),
  INDEX `fk_Matches_Match_Type1_idx` (`Match_Type_id` ASC),
  CONSTRAINT `fk_Matches_Competitions1`
    FOREIGN KEY (`Competitions_id`)
    REFERENCES `robotics`.`Competitions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Matches_Match_Type1`
    FOREIGN KEY (`Match_Type_id`)
    REFERENCES `robotics`.`Match_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `robotics`.`groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `robotics`.`groups` ;

CREATE TABLE IF NOT EXISTS `robotics`.`groups` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `robotics`.`Matches_has_Teams`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `robotics`.`Matches_has_Teams` ;

CREATE TABLE IF NOT EXISTS `robotics`.`Matches_has_Teams` (
  `Matches_id` INT UNSIGNED NOT NULL,
  `groups_id` INT UNSIGNED NOT NULL,
  `Teams_id` INT UNSIGNED NOT NULL,
  `did_win` TINYINT NULL,
  `score` SMALLINT NULL,
  PRIMARY KEY (`Matches_id`, `groups_id`, `Teams_id`),
  INDEX `fk_Matches_has_Teams_Teams1_idx` (`Teams_id` ASC),
  INDEX `fk_Matches_has_Teams_Matches_idx` (`Matches_id` ASC),
  INDEX `fk_Matches_has_Teams_table11_idx` (`groups_id` ASC),
  CONSTRAINT `fk_Matches_has_Teams_Matches`
    FOREIGN KEY (`Matches_id`)
    REFERENCES `robotics`.`Matches` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Matches_has_Teams_Teams1`
    FOREIGN KEY (`Teams_id`)
    REFERENCES `robotics`.`Teams` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Matches_has_Teams_table11`
    FOREIGN KEY (`groups_id`)
    REFERENCES `robotics`.`groups` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `robotics`.`Teams_in_Competitions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `robotics`.`Teams_in_Competitions` ;

CREATE TABLE IF NOT EXISTS `robotics`.`Teams_in_Competitions` (
  `Competitions_id` INT UNSIGNED NOT NULL,
  `Teams_id` INT UNSIGNED NOT NULL,
  `ranking` SMALLINT NULL,
  `ranking_points` SMALLINT NULL,
  PRIMARY KEY (`Competitions_id`, `Teams_id`),
  INDEX `fk_Competitions_has_Teams_Teams1_idx` (`Teams_id` ASC),
  INDEX `fk_Competitions_has_Teams_Competitions1_idx` (`Competitions_id` ASC),
  CONSTRAINT `fk_Competitions_has_Teams_Competitions1`
    FOREIGN KEY (`Competitions_id`)
    REFERENCES `robotics`.`Competitions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Competitions_has_Teams_Teams1`
    FOREIGN KEY (`Teams_id`)
    REFERENCES `robotics`.`Teams` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `robotics`.`Alliances`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `robotics`.`Alliances` ;

CREATE TABLE IF NOT EXISTS `robotics`.`Alliances` (
  `Competitions_id` INT UNSIGNED NOT NULL,
  `Teams_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`Competitions_id`, `Teams_id`),
  INDEX `fk_Competitions_has_Teams1_Teams1_idx` (`Teams_id` ASC),
  INDEX `fk_Competitions_has_Teams1_Competitions1_idx` (`Competitions_id` ASC),
  CONSTRAINT `fk_Competitions_has_Teams1_Competitions1`
    FOREIGN KEY (`Competitions_id`)
    REFERENCES `robotics`.`Competitions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Competitions_has_Teams1_Teams1`
    FOREIGN KEY (`Teams_id`)
    REFERENCES `robotics`.`Teams` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `robotics`.`Pits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `robotics`.`Pits` ;

CREATE TABLE IF NOT EXISTS `robotics`.`Pits` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image` BLOB NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `robotics`.`Pits_in_Competitions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `robotics`.`Pits_in_Competitions` ;

CREATE TABLE IF NOT EXISTS `robotics`.`Pits_in_Competitions` (
  `Pits_id` INT NOT NULL,
  `Competitions_id` INT UNSIGNED NOT NULL,
  `Teams_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Pits_id`, `Competitions_id`, `Teams_id`),
  INDEX `fk_Pits_has_Competitions_Competitions1_idx` (`Competitions_id` ASC),
  INDEX `fk_Pits_has_Competitions_Pits1_idx` (`Pits_id` ASC),
  INDEX `fk_Pits_has_Competitions_Teams1_idx` (`Teams_id` ASC),
  CONSTRAINT `fk_Pits_has_Competitions_Pits1`
    FOREIGN KEY (`Pits_id`)
    REFERENCES `robotics`.`Pits` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pits_has_Competitions_Competitions1`
    FOREIGN KEY (`Competitions_id`)
    REFERENCES `robotics`.`Competitions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pits_has_Competitions_Teams1`
    FOREIGN KEY (`Teams_id`)
    REFERENCES `robotics`.`Teams` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `robotics`.`Awards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `robotics`.`Awards` ;

CREATE TABLE IF NOT EXISTS `robotics`.`Awards` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `award_name` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `robotics`.`Awards_in_Competitions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `robotics`.`Awards_in_Competitions` ;

CREATE TABLE IF NOT EXISTS `robotics`.`Awards_in_Competitions` (
  `Awards_id` INT NOT NULL,
  `Competitions_id` INT UNSIGNED NOT NULL,
  `Teams_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Awards_id`, `Competitions_id`, `Teams_id`),
  INDEX `fk_Awards_has_Competitions_Competitions1_idx` (`Competitions_id` ASC),
  INDEX `fk_Awards_has_Competitions_Awards1_idx` (`Awards_id` ASC),
  INDEX `fk_Awards In Competitions_Teams1_idx` (`Teams_id` ASC),
  CONSTRAINT `fk_Awards_has_Competitions_Awards1`
    FOREIGN KEY (`Awards_id`)
    REFERENCES `robotics`.`Awards` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Awards_has_Competitions_Competitions1`
    FOREIGN KEY (`Competitions_id`)
    REFERENCES `robotics`.`Competitions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Awards In Competitions_Teams1`
    FOREIGN KEY (`Teams_id`)
    REFERENCES `robotics`.`Teams` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `robotics`.`Countries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `robotics`.`Countries` ;

CREATE TABLE IF NOT EXISTS `robotics`.`Countries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
