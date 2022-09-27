-- -----------------------------------------------------
-- Schema cul_ampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cul_ampolla` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `cul_ampolla` ;

-- -----------------------------------------------------
-- Table `cul_ampolla`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`clients` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `client_name` VARCHAR(15) NOT NULL,
  `postal_code` INT NOT NULL,
  `phone` INT NOT NULL,
  `mail` VARCHAR(20) NOT NULL,
  `register_date` DATE NOT NULL,
  `recommendation_id_client` INT NULL DEFAULT NULL,
  `id_glasses` INT NOT NULL,
  PRIMARY KEY (`id_client`, `id_glasses`),
  INDEX `recommendation_id_client_idx` (`recommendation_id_client` ASC) VISIBLE,
  CONSTRAINT `recommendation_id_client`
    FOREIGN KEY (`recommendation_id_client`)
    REFERENCES `cul_ampolla`.`clients` (`id_client`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cul_ampolla`.`providers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`providers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `street` VARCHAR(20) NOT NULL,
  `number` INT NOT NULL,
  `floor` INT NULL DEFAULT NULL,
  `door` VARCHAR(3) NULL DEFAULT NULL,
  `city` VARCHAR(15) NOT NULL,
  `postal_code` INT NOT NULL,
  `country` VARCHAR(15) NOT NULL,
  `phone` INT NOT NULL,
  `fax` INT NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 20
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cul_ampolla`.`worker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`worker` (
  `id_worker` INT NOT NULL AUTO_INCREMENT,
  `worker_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_worker`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cul_ampolla`.`brands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`brands` (
  `id_brand` INT NOT NULL AUTO_INCREMENT,
  `brand_name` VARCHAR(45) NOT NULL,
  `id_provider` INT NOT NULL,
  PRIMARY KEY (`id_brand`),
  INDEX `id_provider_idx` (`id_provider` ASC) VISIBLE,
  CONSTRAINT `id_provider`
    FOREIGN KEY (`id_provider`)
    REFERENCES `cul_ampolla`.`providers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_ampolla`.`glasses_frames`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`glasses_frames` (
  `id_glasses_frame` INT NOT NULL AUTO_INCREMENT,
  `type_frame` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_glasses_frame`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_ampolla`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`glasses` (
  `id_glasses` INT NOT NULL AUTO_INCREMENT,
  `id_provider` INT NOT NULL,
  `id_brand` INT NOT NULL,
  `R_graduation` DECIMAL NOT NULL,
  `L_graduation` DECIMAL NOT NULL,
  `id_glasses_frame` INT NOT NULL,
  `color_frame` VARCHAR(45) NOT NULL,
  `price` DECIMAL NOT NULL,
  PRIMARY KEY (`id_glasses`),
  INDEX `id_provider_idx` (`id_provider` ASC) VISIBLE,
  INDEX `id_brand_idx` (`id_brand` ASC) VISIBLE,
  INDEX `id_frame_idx` (`id_glasses_frame` ASC) VISIBLE,
  CONSTRAINT `glasses.id_provider`
    FOREIGN KEY (`id_provider`)
    REFERENCES `cul_ampolla`.`providers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_brand`
    FOREIGN KEY (`id_brand`)
    REFERENCES `cul_ampolla`.`brands` (`id_brand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_frame`
    FOREIGN KEY (`id_glasses_frame`)
    REFERENCES `cul_ampolla`.`glasses_frames` (`id_glasses_frame`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_ampolla`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`sales` (
  `id_sale` INT NOT NULL AUTO_INCREMENT,
  `id_client` INT NOT NULL,
  `id_glasses` INT NOT NULL,
  `id_worker` INT NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`id_sale`),
  INDEX `id_worker_idx` (`id_worker` ASC) VISIBLE,
  INDEX `id_client` (`id_client` ASC) VISIBLE,
  INDEX `id_glasses_idx` (`id_glasses` ASC) VISIBLE,
  CONSTRAINT `id_client`
    FOREIGN KEY (`id_client`)
    REFERENCES `cul_ampolla`.`clients` (`id_client`),
  CONSTRAINT `id_worker`
    FOREIGN KEY (`id_worker`)
    REFERENCES `cul_ampolla`.`worker` (`id_worker`),
  CONSTRAINT `id_glasses`
    FOREIGN KEY (`id_glasses`)
    REFERENCES `cul_ampolla`.`glasses` (`id_glasses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
