-- =====================================================
-- Views for reporting and data analysis
-- File: database/sql/views/views.sql
-- =====================================================


-- -----------------------------------------------------
-- View: Detailed ticket information
-- Combines tickets, attractions and visitors
-- SELECT * FROM vw_BilhetesDetalhados;
-- -----------------------------------------------------
DROP VIEW IF EXISTS vw_BilhetesDetalhados;

CREATE VIEW vw_BilhetesDetalhados AS
SELECT 
    b.ID AS BilheteID,
    b.Preco AS PrecoBilhete,
    b.DataCompra,
    a.Nome AS NomeAtracao,
    a.Preco AS PrecoAtracao,
    v.Nome AS NomeVisitante
FROM Bilhete b
JOIN Atracao a ON b.AtracaoID = a.ID
JOIN Visitante v ON b.VisitanteID = v.ID;


-- -----------------------------------------------------
-- View: Maintenance records with assigned employees
-- Uses GROUP_CONCAT to list employees per maintenance
-- SELECT * FROM vw_ManutencaoComFuncionarios;
-- -----------------------------------------------------
DROP VIEW IF EXISTS vw_ManutencaoComFuncionarios;

CREATE VIEW vw_ManutencaoComFuncionarios AS
SELECT 
    m.ID AS ManutencaoID,
    m.Data,
    m.Problema,
    m.Descricao,
    a.Nome AS NomeAtracao,
    GROUP_CONCAT(f.Nome SEPARATOR ', ') AS Funcionarios
FROM Manutencao m
JOIN Atracao a ON m.AtracaoID = a.ID
LEFT JOIN Manutencao_Funcionario mf ON m.ID = mf.ID_Manutencao
LEFT JOIN Funcionario f ON mf.ID_Funcionario = f.ID
GROUP BY m.ID;


-- -----------------------------------------------------
-- View: Attractions summary
-- Shows total tickets sold and total revenue per attraction
-- SELECT * FROM vw_ResumoAtracoes;
-- -----------------------------------------------------
DROP VIEW IF EXISTS vw_ResumoAtracoes;

CREATE VIEW vw_ResumoAtracoes AS
SELECT
    a.ID AS AtracaoID,
    a.Nome AS NomeAtracao,
    COUNT(b.ID) AS TotalBilhetes,
    SUM(b.Preco) AS ReceitaTotal
FROM Atracao a
LEFT JOIN Bilhete b ON a.ID = b.AtracaoID
GROUP BY a.ID;
