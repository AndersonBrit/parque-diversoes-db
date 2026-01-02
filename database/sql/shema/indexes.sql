-- database/sql/schema/indexes.sql

USE parque_diversoes;

-- ==============================================
-- Indexes
-- Improve query performance for foreign keys
-- ==============================================
CREATE INDEX idx_bilhete_atracao ON Bilhete(AtracaoID);
CREATE INDEX idx_bilhete_visitante ON Bilhete(VisitanteID);
CREATE INDEX idx_manutencao_atracao ON Manutencao(AtracaoID);