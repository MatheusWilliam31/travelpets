-- MySQL Workbench Synchronization
-- Generated: 2020-06-25 01:55
-- Model: New Model
-- Version: 1.0
-- Project: Travel Pets
-- Author: Matheus William

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

ALTER TABLE `travelpets`.`Cliente` 
ADD INDEX `fk_Cliente_Endereco1_idx` (`Endereco_idEndereco` ASC),
ADD INDEX `fk_Cliente_Telefone1_idx` (`Telefone_idTelefone` ASC),
DROP INDEX `fk_Cliente_Telefone1_idx` ,
DROP INDEX `fk_Cliente_Endereco1_idx` ;

ALTER TABLE `travelpets`.`Pet` 
DROP COLUMN `data_nasc`,
ADD COLUMN `data_nascimento` DATETIME NOT NULL AFTER `peso`,
ADD INDEX `fk_Pet_Cliente1_idx` (`Cliente_idCliente` ASC),
DROP INDEX `fk_Pet_Cliente1_idx` ;

ALTER TABLE `travelpets`.`Motorista` 
DROP COLUMN `nascimento`,
ADD COLUMN `data_nascimento` DATETIME NOT NULL AFTER `nome`,
ADD INDEX `fk_Motorista_Endereco1_idx` (`Endereco_idEndereco` ASC),
ADD INDEX `fk_Motorista_Telefone1_idx` (`Telefone_idTelefone` ASC),
DROP INDEX `fk_Motorista_Telefone1_idx` ,
DROP INDEX `fk_Motorista_Endereco1_idx` ;

CREATE TABLE IF NOT EXISTS `travelpets`.`Viagem` (
  `idViagem` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Motorista_idMotorista` INT(10) UNSIGNED NOT NULL,
  `Veiculo_idVeiculo` INT(10) UNSIGNED NOT NULL,
  `data` DATETIME NOT NULL,
  `detalhe_viagem` VARCHAR(50) NOT NULL,
  `local_partida` VARCHAR(255) NOT NULL,
  `local_chegada` VARCHAR(255) NOT NULL,
  `valor` FLOAT(11) NOT NULL,
  `desconto_viagem` FLOAT(11) NOT NULL,
  `dados_pagar` VARCHAR(100) NOT NULL,
  `autenticacao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idViagem`),
  UNIQUE INDEX `autenticacao_UNIQUE` (`autenticacao` ASC),
  INDEX `fk_Viagem_Motorista1_idx` (`Motorista_idMotorista` ASC),
  INDEX `fk_Viagem_Veiculo1_idx` (`Veiculo_idVeiculo` ASC),
  CONSTRAINT `fk_Viagem_Motorista1`
    FOREIGN KEY (`Motorista_idMotorista`)
    REFERENCES `travelpets`.`Motorista` (`idMotorista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Viagem_Veiculo1`
    FOREIGN KEY (`Veiculo_idVeiculo`)
    REFERENCES `travelpets`.`Veiculo` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `travelpets`.`Pagamento` (
  `idPagamento` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Cliente_idCliente` INT(10) UNSIGNED NOT NULL,
  `Viagem_idViagem` INT(10) UNSIGNED NOT NULL,
  `data` DATETIME NOT NULL,
  `valor_pagamento` FLOAT(11) NOT NULL,
  `autorizacao` INT(10) UNSIGNED NOT NULL,
  `cod_autenticacao` VARCHAR(255) NOT NULL,
  `dados_pagar` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idPagamento`, `Cliente_idCliente`, `Viagem_idViagem`),
  INDEX `fk_Pagamento_Cliente1_idx` (`Cliente_idCliente` ASC),
  INDEX `fk_Pagamento_Viagem1_idx` (`Viagem_idViagem` ASC),
  CONSTRAINT `fk_Pagamento_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `travelpets`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pagamento_Viagem1`
    FOREIGN KEY (`Viagem_idViagem`)
    REFERENCES `travelpets`.`Viagem` (`idViagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `travelpets`.`Pet_viagem` (
  `Viagem_idViagem` INT(10) UNSIGNED NOT NULL,
  `Pet_idPet` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`Viagem_idViagem`, `Pet_idPet`),
  INDEX `fk_Pet_viagem_Viagem1_idx` (`Viagem_idViagem` ASC),
  INDEX `fk_Pet_viagem_Pet1_idx` (`Pet_idPet` ASC),
  CONSTRAINT `fk_Pet_viagem_Viagem1`
    FOREIGN KEY (`Viagem_idViagem`)
    REFERENCES `travelpets`.`Viagem` (`idViagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pet_viagem_Pet1`
    FOREIGN KEY (`Pet_idPet`)
    REFERENCES `travelpets`.`Pet` (`idPet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
