DROP DATABASE IF EXISTS playerstickets;
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema playerstickets
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema playerstickets
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `playerstickets` DEFAULT CHARACTER SET utf8 ;
USE `playerstickets` ;

-- -----------------------------------------------------
-- Table `playerstickets`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playerstickets`.`city` (
  `city_id` INT(11) NULL AUTO_INCREMENT,
  `city` VARCHAR(25) NULL DEFAULT NULL,
  `state_province` VARCHAR(45) NULL,
  PRIMARY KEY (`city_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `playerstickets`.`league`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playerstickets`.`league` (
  `league_id` INT NULL,
  `league` VARCHAR(45) NULL,
  PRIMARY KEY (`league_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playerstickets`.`teams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playerstickets`.`teams` (
  `team_id` INT(11) NULL AUTO_INCREMENT,
  `teamName` VARCHAR(25) NULL DEFAULT NULL,
  `league_league_id` INT NOT NULL,
  PRIMARY KEY (`team_id`),
  INDEX `fk_teams_league1_idx` (`league_league_id` ASC),
  CONSTRAINT `fk_teams_league1`
    FOREIGN KEY (`league_league_id`)
    REFERENCES `playerstickets`.`league` (`league_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `playerstickets`.`fans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playerstickets`.`fans` (
  `fan_id` INT(11) NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NULL DEFAULT NULL,
  `address` VARCHAR(50) NULL DEFAULT NULL,
  `phoneNumber` VARCHAR(10) NULL DEFAULT NULL,
  `team_id` INT(11) NOT NULL,
  PRIMARY KEY (`fan_id`),
  INDEX `team_id` (`team_id` ASC),
  CONSTRAINT `fans_ibfk_1`
    FOREIGN KEY (`team_id`)
    REFERENCES `playerstickets`.`teams` (`team_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `playerstickets`.`game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playerstickets`.`game` (
  `game_id` INT(11) NULL AUTO_INCREMENT,
  `homeTeam` INT(11) NOT NULL,
  `awayTeam` INT(11) NOT NULL,
  PRIMARY KEY (`game_id`),
  INDEX `fk_game_teams1_idx` (`homeTeam` ASC),
  INDEX `fk_game_teams2_idx` (`awayTeam` ASC),
  CONSTRAINT `homeTeam`
    FOREIGN KEY (`homeTeam`)
    REFERENCES `playerstickets`.`teams` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `awayTeam`
    FOREIGN KEY (`awayTeam`)
    REFERENCES `playerstickets`.`teams` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `playerstickets`.`players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playerstickets`.`players` (
  `player_id` INT(11) NULL AUTO_INCREMENT,
  `firstName` VARCHAR(25) NULL DEFAULT NULL,
  `lastName` VARCHAR(25) NULL DEFAULT NULL,
  `captain` TINYINT(1) NULL DEFAULT NULL,
  `team_id` INT(11) NOT NULL,
  PRIMARY KEY (`player_id`),
  INDEX `team_id` (`team_id` ASC),
  UNIQUE INDEX `Only one captain` (`team_id` ASC, `captain` ASC),
  CONSTRAINT `players_ibfk_1`
    FOREIGN KEY (`team_id`)
    REFERENCES `playerstickets`.`teams` (`team_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `playerstickets`.`scorers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playerstickets`.`scorers` (
  `scoreAmount` INT(11) NULL DEFAULT NULL,
  `game_game_id` INT(11) NOT NULL,
  `players_player_id` INT(11) NOT NULL,
  INDEX `fk_scorers_game1_idx` (`game_game_id` ASC),
  INDEX `fk_scorers_players1_idx` (`players_player_id` ASC),
  CONSTRAINT `fk_scorers_game1`
    FOREIGN KEY (`game_game_id`)
    REFERENCES `playerstickets`.`game` (`game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_scorers_players1`
    FOREIGN KEY (`players_player_id`)
    REFERENCES `playerstickets`.`players` (`player_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `playerstickets`.`tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playerstickets`.`tickets` (
  `ticket_id` INT(11) NULL AUTO_INCREMENT,
  `gameDate` DATETIME NULL DEFAULT NULL,
  `game_game_id` INT(11) NOT NULL,
  PRIMARY KEY (`ticket_id`),
  INDEX `fk_tickets_game1_idx` (`game_game_id` ASC),
  CONSTRAINT `fk_tickets_game1`
    FOREIGN KEY (`game_game_id`)
    REFERENCES `playerstickets`.`game` (`game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `playerstickets`.`stadium`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playerstickets`.`stadium` (
  `stadium_id` INT NULL AUTO_INCREMENT,
  `stadiumName` VARCHAR(45) NULL,
  `stadiumSeat` INT NULL,
  `city_city_id` INT(11) NOT NULL,
  `teams_team_id` INT(11) NOT NULL,
  PRIMARY KEY (`stadium_id`),
  INDEX `fk_stadium_city1_idx` (`city_city_id` ASC),
  INDEX `fk_stadium_teams1_idx` (`teams_team_id` ASC),
  CONSTRAINT `fk_stadium_city1`
    FOREIGN KEY (`city_city_id`)
    REFERENCES `playerstickets`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stadium_teams1`
    FOREIGN KEY (`teams_team_id`)
    REFERENCES `playerstickets`.`teams` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playerstickets`.`sweater`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playerstickets`.`sweater` (
  `sweater_id` INT NULL AUTO_INCREMENT,
  `sweater_number` INT NULL,
  `players_player_id` INT(11) NOT NULL,
  `teams_team_id` INT(11) NOT NULL,
  PRIMARY KEY (`sweater_id`),
  INDEX `fk_sweater_players1_idx` (`players_player_id` ASC),
  UNIQUE INDEX `composite index` (`teams_team_id` ASC, `sweater_number` ASC),
  INDEX `fk_sweater_teams1_idx` (`teams_team_id` ASC),
  CONSTRAINT `fk_sweater_players1`
    FOREIGN KEY (`players_player_id`)
    REFERENCES `playerstickets`.`players` (`player_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sweater_teams1`
    FOREIGN KEY (`teams_team_id`)
    REFERENCES `playerstickets`.`teams` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

