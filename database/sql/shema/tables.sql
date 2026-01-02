-- database/sql/schema/tables.sql

USE parque_diversoes;

-- ==============================================
-- Table: Atracao
-- Stores the amusement park attractions
-- ==============================================
CREATE TABLE Atracao (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,                 -- Name of the attraction (required)
    Preco DECIMAL(6,2) NOT NULL DEFAULT 0.00,   -- Ticket price
    Horario_inicio TIME,                        -- Start time of operation
    Horario_fim TIME,                           -- End time of operation
    Num_Pessoas INT NOT NULL DEFAULT 1,         -- Capacity (at least 1)
    Peso_Min DECIMAL(5,2),                      -- Optional minimum weight
    Peso_Max DECIMAL(5,2),                      -- Optional maximum weight
    Altura_Min DECIMAL(5,2),                    -- Optional minimum height
    Altura_Max DECIMAL(5,2),                    -- Optional maximum height
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- Record creation timestamp
    CHECK (Num_Pessoas >= 1),
    CHECK (Preco >= 0),
    CHECK (Peso_Min IS NULL OR Peso_Max IS NULL OR Peso_Min <= Peso_Max),
    CHECK (Altura_Min IS NULL OR Altura_Max IS NULL OR Altura_Min <= Altura_Max)
);

-- ==============================================
-- Table: Manutencao
-- Stores maintenance records for attractions
-- ==============================================
CREATE TABLE Manutencao (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Data DATE NOT NULL,                           -- Date of maintenance
    Problema VARCHAR(200),                        -- Problem summary
    Descricao TEXT,                               -- Detailed description
    AtracaoID INT NOT NULL,                       -- Related attraction
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (AtracaoID) REFERENCES Atracao(ID)
      ON UPDATE CASCADE     -- Update all references if attraction ID changes
      ON DELETE RESTRICT    -- Prevent deletion if linked records exist
);

-- ==============================================
-- Table: Funcionario
-- Stores employee information
-- ==============================================
CREATE TABLE Funcionario (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,                  -- Employee name
    Funcao VARCHAR(50),                          -- Role/position
    Turno VARCHAR(50),                            -- Work shift
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ==============================================
-- Table: Manutencao_Funcionario
-- Many-to-many relationship between maintenance and employees
-- ==============================================
CREATE TABLE Manutencao_Funcionario (
    ID_Funcionario INT NOT NULL,
    ID_Manutencao INT NOT NULL,
    PRIMARY KEY (ID_Funcionario, ID_Manutencao),
    FOREIGN KEY (ID_Funcionario) REFERENCES Funcionario(ID)
      ON UPDATE CASCADE
      ON DELETE CASCADE,   -- Remove associations if employee deleted
    FOREIGN KEY (ID_Manutencao) REFERENCES Manutencao(ID)
      ON UPDATE CASCADE
      ON DELETE CASCADE    -- Remove associations if maintenance deleted
);

-- ==============================================
-- Table: Visitante
-- Stores park visitors
-- ==============================================
CREATE TABLE Visitante (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),                            -- Visitor name (optional)
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ==============================================
-- Table: Bilhete
-- Stores tickets purchased by visitors for attractions
-- ==============================================
CREATE TABLE Bilhete (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Preco DECIMAL(6,2) NOT NULL,                 -- Ticket price
    DataCompra DATE NOT NULL,                     -- Purchase date
    AtracaoID INT NOT NULL,                       -- Linked attraction
    VisitanteID INT NOT NULL,                     -- Linked visitor
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (AtracaoID) REFERENCES Atracao(ID)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,                        -- Prevent deletion of attractions with tickets
    FOREIGN KEY (VisitanteID) REFERENCES Visitante(ID)
      ON UPDATE CASCADE
);

