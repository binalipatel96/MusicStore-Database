-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`artists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`artists` (
  `artist_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(55) NULL,
  `last_name` VARCHAR(55) NULL,
  PRIMARY KEY (`artist_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`genre` (
  `genre_id` INT NOT NULL AUTO_INCREMENT,
  `genre_name` VARCHAR(45) NULL,
  PRIMARY KEY (`genre_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ratings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ratings` (
  `rating_id` INT NOT NULL AUTO_INCREMENT,
  `rating_value` INT NULL,
  `rating_date` DATE NULL,
  `comments` VARCHAR(60) NULL,
  PRIMARY KEY (`rating_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`languages` (
  `language_id` INT NOT NULL AUTO_INCREMENT,
  `language_name` VARCHAR(45) NULL,
  PRIMARY KEY (`language_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`product_type` (
  `product_type_id` INT NOT NULL AUTO_INCREMENT,
  `product_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`product_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`albums`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`albums` (
  `album_id` INT NOT NULL AUTO_INCREMENT,
  `album_name` VARCHAR(55) NULL,
  `artist_id` INT NOT NULL,
  `genre_id` INT NOT NULL,
  `rating_id` INT NOT NULL,
  `language_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `album_qty` INT NULL,
  `album_price` DOUBLE NULL,
  PRIMARY KEY (`album_id`),
  INDEX `fk_albums_artists1_idx` (`artist_id` ASC) ,
  INDEX `fk_albums_genre1_idx` (`genre_id` ASC) ,
  INDEX `fk_albums_ratings1_idx` (`rating_id` ASC) ,
  INDEX `fk_albums_languages1_idx` (`language_id` ASC) ,
  INDEX `fk_albums_products1_idx` (`product_id` ASC) ,
  CONSTRAINT `fk_albums_artists1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `mydb`.`artists` (`artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_albums_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `mydb`.`genre` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_albums_ratings1`
    FOREIGN KEY (`rating_id`)
    REFERENCES `mydb`.`ratings` (`rating_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_albums_languages1`
    FOREIGN KEY (`language_id`)
    REFERENCES `mydb`.`languages` (`language_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_albums_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `mydb`.`product_type` (`product_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`countries` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(45) NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`provinces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`provinces` (
  `province_id` INT NOT NULL AUTO_INCREMENT,
  `province_name` VARCHAR(45) NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`province_id`),
  INDEX `fk_provinces_countries1_idx` (`country_id` ASC) ,
  CONSTRAINT `fk_provinces_countries1`
    FOREIGN KEY (`country_id`)
    REFERENCES `mydb`.`countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cities` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(45) NULL,
  `province_id` INT NOT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `fk_cities_provinces1_idx` (`province_id` ASC) ,
  CONSTRAINT `fk_cities_provinces1`
    FOREIGN KEY (`province_id`)
    REFERENCES `mydb`.`provinces` (`province_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`addresses` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `address_line1` VARCHAR(55) NULL,
  `postal_code` VARCHAR(45) NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_addresses_cities_idx` (`city_id` ASC) ,
  CONSTRAINT `fk_addresses_cities`
    FOREIGN KEY (`city_id`)
    REFERENCES `mydb`.`cities` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_customers_addresses1_idx` (`address_id` ASC) ,
  CONSTRAINT `fk_customers_addresses1`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `order_date` DATE NOT NULL,
  `payment_date` DATE NOT NULL,
  `payment_total` DECIMAL(9,2) NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_invoices_customers1_idx` (`customer_id` ASC) ,
  CONSTRAINT `fk_invoices_customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order_items` (
  `order_item_id` INT NOT NULL AUTO_INCREMENT,
  `order_qty` INT NULL,
  `price_item` DOUBLE NULL,
  `order_id` INT NOT NULL,
  `album_id` INT NOT NULL,
  PRIMARY KEY (`order_item_id`),
  INDEX `fk_order_items_orders1_idx` (`order_id` ASC) ,
  INDEX `fk_order_items_albums1_idx` (`album_id` ASC) ,
  CONSTRAINT `fk_order_items_orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_items_albums1`
    FOREIGN KEY (`album_id`)
    REFERENCES `mydb`.`albums` (`album_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
