-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema robotics
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema robotics
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `robotics` DEFAULT CHARACTER SET latin1 ;
USE `robotics` ;

-- -----------------------------------------------------
-- Table `robotics`.`Countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robotics`.`Countries` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL COMMENT 'official name of country',
  `code` VARCHAR(2) NOT NULL COMMENT 'each country is given a unique code, so they can be easily identified by users.',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 751
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `robotics`.`Districts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robotics`.`Districts` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Countries_id` INT(10) UNSIGNED NOT NULL,
  `numeric_code` INT(10) UNSIGNED NOT NULL COMMENT 'each district is given a unique numeric code, so they can be easily identified by users.',
  `code` VARCHAR(20) NOT NULL COMMENT 'each district is given a unique code, so they can be easily identified by users.',
  `name` VARCHAR(120) CHARACTER SET 'utf8' NOT NULL COMMENT 'official name of teh district',
  PRIMARY KEY (`id`, `Countries_id`),
  UNIQUE INDEX `code_UNIQUE` (`numeric_code` ASC) VISIBLE,
  INDEX `fk_Districts_Countries1_idx` (`Countries_id` ASC) VISIBLE,
  CONSTRAINT `fk_Districts_Countries1`
    FOREIGN KEY (`Countries_id`)
    REFERENCES `robotics`.`Countries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 15253
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `robotics`.`Cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robotics`.`Cities` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Districts_id` INT(10) UNSIGNED NOT NULL,
  `numeric_code` INT(11) NOT NULL COMMENT 'each city is given a unique code, so they can be easily identified by users.',
  `name` VARCHAR(120) CHARACTER SET 'utf8' NOT NULL COMMENT 'official name of the city',
  PRIMARY KEY (`id`, `Districts_id`),
  UNIQUE INDEX `numeric_code_UNIQUE` (`numeric_code` ASC) VISIBLE,
  INDEX `fk_Cities_Districts1_idx` (`Districts_id` ASC) VISIBLE,
  CONSTRAINT `fk_Cities_Districts1`
    FOREIGN KEY (`Districts_id`)
    REFERENCES `robotics`.`Districts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 451723
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `robotics`.`Competitions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robotics`.`Competitions` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Cities_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `code` VARCHAR(20) NOT NULL COMMENT 'unique code given to a comp, so it can be easily identified by a name. codes will have a naming convention, for example, a competition that happened in israel in 2019 can be given the name:\\n- isr2019\\nso it can be easily identified by users.\\n',
  `start_date` DATE NULL DEFAULT NULL COMMENT 'starting date of a comp',
  `end_date` DATE NULL DEFAULT NULL COMMENT 'ending date of a comp',
  `name` VARCHAR(1027) CHARACTER SET 'utf8' NOT NULL COMMENT 'name if comp',
  `website` VARCHAR(255) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT 'link for a website that is realted to the competition',
  `address` VARCHAR(255) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT 'address of a competition. not constrained by a key so it can be very specific for local purposes. ',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) VISIBLE,
  INDEX `fk_Competitions_Cities1_idx` (`Cities_id` ASC) VISIBLE,
  CONSTRAINT `fk_Competitions_Cities1`
    FOREIGN KEY (`Cities_id`)
    REFERENCES `robotics`.`Cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6641
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `robotics`.`Alliances`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robotics`.`Alliances` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Competitions_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Competitions_has_Teams1_Competitions1_idx` (`Competitions_id` ASC) VISIBLE,
  CONSTRAINT `fk_Competitions_has_Teams1_Competitions1`
    FOREIGN KEY (`Competitions_id`)
    REFERENCES `robotics`.`Competitions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 15525
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `robotics`.`Awards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robotics`.`Awards` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `award_name` VARCHAR(45) NOT NULL COMMENT 'an award is given to a team who has shown: \\n- extraordinary effort in a given field\\n- a unique and out of the box result\\n- success in the tournament\\n- and more...\\n\\neach award has a unique purpose. ',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `award_name_UNIQUE` (`award_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 83
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `robotics`.`Teams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robotics`.`Teams` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Cities_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `name` VARCHAR(1027) CHARACTER SET 'utf8' NOT NULL,
  `nickname` VARCHAR(255) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT 'each team can decide on a nickname for themselfs\\n ',
  `rookie_year` YEAR(4) NULL DEFAULT NULL COMMENT 'the first year the team participated in a competition',
  `team_number` SMALLINT(5) UNSIGNED NOT NULL COMMENT 'each team has a unique number. teams can forfiet, be deleted, and change number, so its best to not use it as an identifier.',
  `website` VARCHAR(255) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `team_number_UNIQUE` (`team_number` ASC) VISIBLE,
  INDEX `fk_Teams_Cities1_idx` (`Cities_id` ASC) VISIBLE,
  CONSTRAINT `fk_Teams_Cities1`
    FOREIGN KEY (`Cities_id`)
    REFERENCES `robotics`.`Cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 23796
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `robotics`.`Awards_in_Competitions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robotics`.`Awards_in_Competitions` (
  `Awards_id` INT(11) NOT NULL,
  `Competitions_id` INT(10) UNSIGNED NOT NULL,
  `Teams_id` INT(10) UNSIGNED NOT NULL COMMENT 'the team that is given the award',
  PRIMARY KEY (`Awards_id`, `Competitions_id`, `Teams_id`),
  INDEX `fk_Awards_has_Competitions_Competitions1_idx` (`Competitions_id` ASC) VISIBLE,
  INDEX `fk_Awards_has_Competitions_Awards1_idx` (`Awards_id` ASC) VISIBLE,
  INDEX `fk_Awards In Competitions_Teams1_idx` (`Teams_id` ASC) VISIBLE,
  CONSTRAINT `fk_Awards In Competitions_Teams1`
    FOREIGN KEY (`Teams_id`)
    REFERENCES `robotics`.`Teams` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Awards_has_Competitions_Awards1`
    FOREIGN KEY (`Awards_id`)
    REFERENCES `robotics`.`Awards` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Awards_has_Competitions_Competitions1`
    FOREIGN KEY (`Competitions_id`)
    REFERENCES `robotics`.`Competitions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `robotics`.`Match_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robotics`.`Match_Type` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL COMMENT 'each match has a type. a type can represent if a match is a match in the first part, the second part, the finals and more...',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `type_UNIQUE` (`type` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `robotics`.`groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robotics`.`groups` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL COMMENT 'a group is an identifier for a set of teams in a match. in a match there is two groups/alliances fighting each other. \\ngroups and alliances are different from each other:\\n- groups are formed by the competition managers beforehead, and they represent sets of teams that fight each other in each match in the first part of the competition. they are different each match, but they can be formed again if necessary.\\n- alliance are formed by teams in the secind part of the comp, and they are the sets of teams that fight each other in each match in the first second of the competition. they are the same for each match.\\n',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `robotics`.`Matches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robotics`.`Matches` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Competitions_id` INT(10) UNSIGNED NOT NULL,
  `Match_Type_id` INT(10) UNSIGNED NOT NULL,
  `code` VARCHAR(20) NOT NULL COMMENT 'a unique code given to a match. matches in the same competition will have a naming convention.',
  `group1_score` SMALLINT(6) NOT NULL COMMENT 'score of group/alliance 1 in the match. ',
  `group2_score` SMALLINT(6) NOT NULL COMMENT 'score of group/alliance 2 in the match. ',
  `group_won` INT(10) UNSIGNED NOT NULL COMMENT 'identified which group won',
  `match_number` SMALLINT(5) UNSIGNED NULL DEFAULT NULL COMMENT 'the number of the match in a comp.',
  `start_datetime` DATETIME NULL DEFAULT NULL,
  `end_datetime` DATETIME NULL DEFAULT NULL,
  `group1_rp` TINYINT(4) NULL DEFAULT NULL COMMENT 'ranking points got by group/alliance 1 in the match. ',
  `group2_rp` TINYINT(4) NULL DEFAULT NULL COMMENT 'ranking points got by group/alliance 2 in the match. ',
  PRIMARY KEY (`id`, `Competitions_id`, `Match_Type_id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) VISIBLE,
  INDEX `fk_Matches_Competitions1_idx` (`Competitions_id` ASC) VISIBLE,
  INDEX `fk_Matches_Match_Type1_idx` (`Match_Type_id` ASC) VISIBLE,
  INDEX `fk_Matches_groups1_idx` (`group_won` ASC) VISIBLE,
  CONSTRAINT `fk_Matches_Competitions1`
    FOREIGN KEY (`Competitions_id`)
    REFERENCES `robotics`.`Competitions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Matches_Match_Type1`
    FOREIGN KEY (`Match_Type_id`)
    REFERENCES `robotics`.`Match_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Matches_groups1`
    FOREIGN KEY (`group_won`)
    REFERENCES `robotics`.`groups` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 413195
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `robotics`.`Matches_has_Teams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robotics`.`Matches_has_Teams` (
  `Matches_id` INT(10) UNSIGNED NOT NULL,
  `groups_id` INT(10) UNSIGNED NOT NULL,
  `Teams_id` INT(10) UNSIGNED NOT NULL,
  `did_win` TINYINT(4) NULL DEFAULT NULL COMMENT 'did group/alliance of the team in match won.',
  `score` SMALLINT(6) NULL DEFAULT NULL COMMENT 'score of the whole group/alliance in the match.',
  PRIMARY KEY (`Matches_id`, `groups_id`, `Teams_id`),
  UNIQUE INDEX `unique_team_in_same_match` (`Matches_id` ASC, `Teams_id` ASC, `groups_id` ASC) VISIBLE,
  INDEX `fk_Matches_has_Teams_Teams1_idx` (`Teams_id` ASC) VISIBLE,
  INDEX `fk_Matches_has_Teams_Matches_idx` (`Matches_id` ASC) VISIBLE,
  INDEX `fk_Matches_has_Teams_table11_idx` (`groups_id` ASC) VISIBLE,
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
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `robotics`.`Pits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robotics`.`Pits` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `image` LONGBLOB NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 101
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `robotics`.`Pits_in_Competitions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robotics`.`Pits_in_Competitions` (
  `Pits_id` INT(11) NOT NULL,
  `Competitions_id` INT(10) UNSIGNED NOT NULL,
  `Teams_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`Pits_id`, `Competitions_id`, `Teams_id`),
  INDEX `fk_Pits_has_Competitions_Competitions1_idx` (`Competitions_id` ASC) VISIBLE,
  INDEX `fk_Pits_has_Competitions_Pits1_idx` (`Pits_id` ASC) VISIBLE,
  INDEX `fk_Pits_has_Competitions_Teams1_idx` (`Teams_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pits_has_Competitions_Competitions1`
    FOREIGN KEY (`Competitions_id`)
    REFERENCES `robotics`.`Competitions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pits_has_Competitions_Pits1`
    FOREIGN KEY (`Pits_id`)
    REFERENCES `robotics`.`Pits` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pits_has_Competitions_Teams1`
    FOREIGN KEY (`Teams_id`)
    REFERENCES `robotics`.`Teams` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `robotics`.`Teams_in_Alliance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robotics`.`Teams_in_Alliance` (
  `Alliances_id` INT(10) UNSIGNED NOT NULL,
  `Teams_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`Alliances_id`, `Teams_id`),
  INDEX `fk_Teams_in_Alliance_Alliances1_idx` (`Alliances_id` ASC) VISIBLE,
  INDEX `fk_Teams_in_Alliance_Teams1_idx` (`Teams_id` ASC) VISIBLE,
  CONSTRAINT `fk_Teams_in_Alliance_1`
    FOREIGN KEY (`Alliances_id`)
    REFERENCES `robotics`.`Alliances` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Teams_in_Alliance_Teams1`
    FOREIGN KEY (`Teams_id`)
    REFERENCES `robotics`.`Teams` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `robotics`.`Teams_in_Competitions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robotics`.`Teams_in_Competitions` (
  `Competitions_id` INT(10) UNSIGNED NOT NULL,
  `Teams_id` INT(10) UNSIGNED NOT NULL,
  `ranking` SMALLINT(8) NULL DEFAULT NULL COMMENT 'at what place the team was at the end of the comp ',
  PRIMARY KEY (`Competitions_id`, `Teams_id`),
  UNIQUE INDEX `unique_team_in_same_competition` (`Competitions_id` ASC, `Teams_id` ASC) VISIBLE,
  INDEX `fk_Competitions_has_Teams_Teams1_idx` (`Teams_id` ASC) VISIBLE,
  INDEX `fk_Competitions_has_Teams_Competitions1_idx` (`Competitions_id` ASC) VISIBLE,
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
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

USE `robotics` ;

-- -----------------------------------------------------
-- procedure GetCompetitionAwardsWithTeams
-- -----------------------------------------------------

DELIMITER $$
USE `robotics`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCompetitionAwardsWithTeams`(
	IN competition_id INT
)
BEGIN
  SELECT 
    c.name AS competition_name,
    a.award_name AS award_name,
    t.name AS team_name,
    COUNT(*) AS awarded_count
  FROM Competitions c
  INNER JOIN Awards_in_Competitions aic ON c.id = aic.Competitions_id
  INNER JOIN Awards a ON aic.Awards_id = a.id
  INNER JOIN Teams_in_Competitions tic ON c.id = tic.Competitions_id
  INNER JOIN Teams t ON tic.Teams_id = t.id
  WHERE tic.Teams_id = aic.teams_id  -- Team awarded based on Awards_in_Competitions
  AND c.id = competition_id  -- Filter by competition ID (assuming Awards_in_Competitions references competition ID)
  GROUP BY c.id, a.id, t.id
  ORDER BY c.name ASC, a.award_name ASC, t.name ASC;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetSharedCompetitions
-- -----------------------------------------------------

DELIMITER $$
USE `robotics`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSharedCompetitions`(
	IN team1_id INT, 
    IN team2_id INT
)
BEGIN
  SELECT DISTINCT c.name AS competition_name, c.start_date, c.end_date
  FROM Competitions c
  INNER JOIN Teams_in_Competitions tic1 ON c.id = tic1.Competitions_id
  INNER JOIN Teams_in_Competitions tic2 ON c.id = tic2.Competitions_id
  WHERE tic1.Teams_id = team1_id
  AND tic2.Teams_id = team2_id
  AND tic1.Teams_id != tic2.Teams_id -- Avoid self-joins (team competing against itself)
  ORDER BY c.start_date ASC;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function GetTeamWithMostWinsInDistrict
-- -----------------------------------------------------

DELIMITER $$
USE `robotics`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetTeamWithMostWinsInDistrict`(districtId INT(10) UNSIGNED) RETURNS int(10) unsigned
BEGIN
    DECLARE teamId INT(10) UNSIGNED;

    -- Get the team with the most overall match wins in the district
    SELECT
        Teams.id INTO teamId
    FROM
        robotics.Matches_has_Teams
        JOIN robotics.Matches ON Matches_has_Teams.Matches_id = Matches.id
        JOIN robotics.Teams ON Matches_has_Teams.Teams_id = Teams.id
    WHERE
        Teams.Cities_id IN (
            SELECT
                Cities_id
            FROM
                robotics.Districts
            WHERE
                Districts.id = districtId
        )
        AND Matches_has_Teams.did_win = 1
    GROUP BY
        Teams.id
    ORDER BY
        COUNT(Matches_has_Teams.Teams_id) DESC
    LIMIT 1;

    RETURN teamId;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
