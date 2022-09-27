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
-- Table `mydb`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`client` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `client_name` VARCHAR(45) NOT NULL,
  `client_surname` VARCHAR(45) NOT NULL,
  `client_adress` VARCHAR(45) NOT NULL,
  `client_postalcode` INT NOT NULL,
  `township` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  `phone` INT(9) NOT NULL,
  PRIMARY KEY (`id_client`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`shop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`shop` (
  `id_shop` INT NOT NULL AUTO_INCREMENT,
  `shop_address` VARCHAR(45) NOT NULL,
  `postal_code` INT(5) NOT NULL,
  `township` VARCHAR(45) NOT NULL,
  `shopcol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_shop`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`workers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`workers` (
  `id_worker` INT NOT NULL AUTO_INCREMENT,
  `id_shop` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `NIF` INT NOT NULL,
  `phone` INT(9) NOT NULL,
  `worker_category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_worker`),
  INDEX `id_shop_idx` (`id_shop` ASC) VISIBLE,
  CONSTRAINT `id_shop`
    FOREIGN KEY (`id_shop`)
    REFERENCES `mydb`.`shop` (`id_shop`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order` (
  `id_order` INT NOT NULL AUTO_INCREMENT,
  `id_client` INT NOT NULL,
  `id_worker` INT NOT NULL,
  `order_date` DATE NOT NULL,
  `product_quantity` INT NOT NULL,
  `shop_or_delivery` VARCHAR(45) NOT NULL,
  `id_shop` INT NOT NULL,
  `total_price` DECIMAL NOT NULL,
  PRIMARY KEY (`id_order`),
  INDEX `id_client_idx` (`id_client` ASC) VISIBLE,
  INDEX `id_worker_idx` (`id_worker` ASC) VISIBLE,
  INDEX `id_shop_idx` (`id_shop` ASC) VISIBLE,
  CONSTRAINT `id_client`
    FOREIGN KEY (`id_client`)
    REFERENCES `mydb`.`client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_worker`
    FOREIGN KEY (`id_worker`)
    REFERENCES `mydb`.`workers` (`id_worker`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `order.id_shop`
    FOREIGN KEY (`id_shop`)
    REFERENCES `mydb`.`shop` (`id_shop`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`hamburguer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`hamburguer` (
  `id_hamburguer` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `image` VARCHAR(45) NULL,
  `description` VARCHAR(45) NOT NULL,
  `price` DECIMAL NOT NULL,
  `id_order` INT NOT NULL,
  PRIMARY KEY (`id_hamburguer`),
  INDEX `id_order_idx` (`id_order` ASC) VISIBLE,
  CONSTRAINT `hamburguer.id_order`
    FOREIGN KEY (`id_order`)
    REFERENCES `mydb`.`order` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `id_category` INT NOT NULL AUTO_INCREMENT,
  `category_nam` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_category`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pizza` (
  `id_pizza` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `image` VARCHAR(45) NULL,
  `description` VARCHAR(45) NOT NULL,
  `price` DECIMAL NOT NULL,
  `id_category` INT NOT NULL,
  `id_order` INT NOT NULL,
  PRIMARY KEY (`id_pizza`),
  INDEX `id_category_idx` (`id_category` ASC) VISIBLE,
  INDEX `id_order_idx` (`id_order` ASC) VISIBLE,
  CONSTRAINT `id_category`
    FOREIGN KEY (`id_category`)
    REFERENCES `mydb`.`category` (`id_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pizza.id_order`
    FOREIGN KEY (`id_order`)
    REFERENCES `mydb`.`order` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`drinks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`drinks` (
  `id_drink` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `image` VARCHAR(45) NULL,
  `description` VARCHAR(45) NOT NULL,
  `price` DECIMAL NOT NULL,
  `id_order` INT NOT NULL,
  PRIMARY KEY (`id_drink`),
  INDEX `id_order_idx` (`id_order` ASC) VISIBLE,
  CONSTRAINT `drinks.id_order`
    FOREIGN KEY (`id_order`)
    REFERENCES `mydb`.`order` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`delivery` (
  `id_delivery` INT NOT NULL AUTO_INCREMENT,
  `id_worker` INT NOT NULL,
  `delivery_date` DATE NOT NULL,
  `id_order` INT NOT NULL,
  PRIMARY KEY (`id_delivery`),
  INDEX `id_worker_idx` (`id_worker` ASC) VISIBLE,
  INDEX `id_order_idx` (`id_order` ASC) VISIBLE,
  CONSTRAINT `delivery.id_worker`
    FOREIGN KEY (`id_worker`)
    REFERENCES `mydb`.`workers` (`id_worker`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `delivery.id_order`
    FOREIGN KEY (`id_order`)
    REFERENCES `mydb`.`order` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
