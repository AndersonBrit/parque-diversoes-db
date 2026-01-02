-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 02-Jan-2026 às 20:09
-- Versão do servidor: 10.4.32-MariaDB
-- versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `parque_diversoes`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `atracao`
--

CREATE TABLE `atracao` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(100) NOT NULL,
  `Preco` decimal(6,2) NOT NULL DEFAULT 0.00,
  `Horario_inicio` time DEFAULT NULL,
  `Horario_fim` time DEFAULT NULL,
  `Num_Pessoas` int(11) NOT NULL DEFAULT 1,
  `Peso_Min` decimal(5,2) DEFAULT NULL,
  `Peso_Max` decimal(5,2) DEFAULT NULL,
  `Altura_Min` decimal(5,2) DEFAULT NULL,
  `Altura_Max` decimal(5,2) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `bilhete`
--

CREATE TABLE `bilhete` (
  `ID` int(11) NOT NULL,
  `Preco` decimal(6,2) NOT NULL,
  `DataCompra` date NOT NULL,
  `AtracaoID` int(11) NOT NULL,
  `VisitanteID` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `funcionario`
--

CREATE TABLE `funcionario` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(100) NOT NULL,
  `Funcao` varchar(50) DEFAULT NULL,
  `Turno` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `manutencao`
--

CREATE TABLE `manutencao` (
  `ID` int(11) NOT NULL,
  `Data` date NOT NULL,
  `Problema` varchar(200) DEFAULT NULL,
  `Descricao` text DEFAULT NULL,
  `AtracaoID` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `manutencao_funcionario`
--

CREATE TABLE `manutencao_funcionario` (
  `ID_Funcionario` int(11) NOT NULL,
  `ID_Manutencao` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `visitante`
--

CREATE TABLE `visitante` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `atracao`
--
ALTER TABLE `atracao`
  ADD PRIMARY KEY (`ID`);

--
-- Índices para tabela `bilhete`
--
ALTER TABLE `bilhete`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `idx_bilhete_atracao` (`AtracaoID`),
  ADD KEY `idx_bilhete_visitante` (`VisitanteID`);

--
-- Índices para tabela `funcionario`
--
ALTER TABLE `funcionario`
  ADD PRIMARY KEY (`ID`);

--
-- Índices para tabela `manutencao`
--
ALTER TABLE `manutencao`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `idx_manutencao_atracao` (`AtracaoID`);

--
-- Índices para tabela `manutencao_funcionario`
--
ALTER TABLE `manutencao_funcionario`
  ADD PRIMARY KEY (`ID_Funcionario`,`ID_Manutencao`),
  ADD KEY `ID_Manutencao` (`ID_Manutencao`);

--
-- Índices para tabela `visitante`
--
ALTER TABLE `visitante`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `atracao`
--
ALTER TABLE `atracao`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `bilhete`
--
ALTER TABLE `bilhete`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `funcionario`
--
ALTER TABLE `funcionario`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `manutencao`
--
ALTER TABLE `manutencao`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `visitante`
--
ALTER TABLE `visitante`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `bilhete`
--
ALTER TABLE `bilhete`
  ADD CONSTRAINT `bilhete_ibfk_1` FOREIGN KEY (`AtracaoID`) REFERENCES `atracao` (`ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `bilhete_ibfk_2` FOREIGN KEY (`VisitanteID`) REFERENCES `visitante` (`ID`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `manutencao`
--
ALTER TABLE `manutencao`
  ADD CONSTRAINT `manutencao_ibfk_1` FOREIGN KEY (`AtracaoID`) REFERENCES `atracao` (`ID`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `manutencao_funcionario`
--
ALTER TABLE `manutencao_funcionario`
  ADD CONSTRAINT `manutencao_funcionario_ibfk_1` FOREIGN KEY (`ID_Funcionario`) REFERENCES `funcionario` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `manutencao_funcionario_ibfk_2` FOREIGN KEY (`ID_Manutencao`) REFERENCES `manutencao` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
