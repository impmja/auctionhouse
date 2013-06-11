SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `auctionhouse` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `auctionhouse` ;

-- -----------------------------------------------------
-- Table `auctionhouse`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auctionhouse`.`Users` ;

CREATE  TABLE IF NOT EXISTS `auctionhouse`.`Users` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `email` VARCHAR(256) NOT NULL ,
  `password` VARCHAR(256) NOT NULL ,
  `first_name` VARCHAR(256) NOT NULL ,
  `last_name` VARCHAR(256) NOT NULL ,
  `street_name` VARCHAR(256) NOT NULL ,
  `zip_code` VARCHAR(20) NOT NULL ,
  `city` VARCHAR(256) NOT NULL ,
  `country` VARCHAR(256) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auctionhouse`.`Article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auctionhouse`.`Article` ;

CREATE  TABLE IF NOT EXISTS `auctionhouse`.`Article` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `seller_id` INT NOT NULL ,
  `image_id` INT NULL ,
  `title` VARCHAR(256) NOT NULL ,
  `description` VARCHAR(256) NULL ,
  `is_direct_buy` TINYINT NOT NULL ,
  `start_price` INT NOT NULL ,
  `end_date` DATETIME NOT NULL ,
  `creation_date` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Article_User_idx` (`seller_id` ASC) ,
  CONSTRAINT `fk_Article_User`
    FOREIGN KEY (`seller_id` )
    REFERENCES `auctionhouse`.`Users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auctionhouse`.`Image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auctionhouse`.`Image` ;

CREATE  TABLE IF NOT EXISTS `auctionhouse`.`Image` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `article_id` INT NOT NULL ,
  `uri` VARCHAR(256) NOT NULL ,
  `creation_date` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Image_Article1_idx` (`article_id` ASC) ,
  CONSTRAINT `fk_Image_Article1`
    FOREIGN KEY (`article_id` )
    REFERENCES `auctionhouse`.`Article` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auctionhouse`.`Bid`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auctionhouse`.`Bid` ;

CREATE  TABLE IF NOT EXISTS `auctionhouse`.`Bid` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `bidder_id` INT NOT NULL ,
  `article_id` INT NOT NULL ,
  `bid` INT NOT NULL COMMENT 'Value in Cents' ,
  `bid_date` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Bid_User1_idx` (`bidder_id` ASC) ,
  INDEX `fk_Bid_Article1_idx` (`article_id` ASC) ,
  CONSTRAINT `fk_Bid_User1`
    FOREIGN KEY (`bidder_id` )
    REFERENCES `auctionhouse`.`Users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bid_Article1`
    FOREIGN KEY (`article_id` )
    REFERENCES `auctionhouse`.`Article` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auctionhouse`.`Purchases`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auctionhouse`.`Purchases` ;

CREATE  TABLE IF NOT EXISTS `auctionhouse`.`Purchases` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user_id` INT NOT NULL ,
  `article_id` INT NOT NULL ,
  `price` INT NULL ,
  `purchase_date` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Purchases_User1_idx` (`user_id` ASC) ,
  INDEX `fk_Purchases_Article1_idx` (`article_id` ASC) ,
  CONSTRAINT `fk_Purchases_User1`
    FOREIGN KEY (`user_id` )
    REFERENCES `auctionhouse`.`Users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Purchases_Article1`
    FOREIGN KEY (`article_id` )
    REFERENCES `auctionhouse`.`Article` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auctionhouse`.`Comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auctionhouse`.`Comments` ;

CREATE  TABLE IF NOT EXISTS `auctionhouse`.`Comments` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `article_id` INT NOT NULL ,
  `user_id` INT NOT NULL ,
  `comment` VARCHAR(256) NOT NULL ,
  `creation_date` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Comments_Article1_idx` (`article_id` ASC) ,
  INDEX `fk_Comments_User1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_Comments_Article1`
    FOREIGN KEY (`article_id` )
    REFERENCES `auctionhouse`.`Article` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comments_User1`
    FOREIGN KEY (`user_id` )
    REFERENCES `auctionhouse`.`Users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
