-- Exemplos de validação: substitua SEU_PROJETO pelo ID do seu projeto.
-- Queries de leitura; NÃO criam nem alteram tabelas.

-- Qualidade cadastral
SELECT
  COUNT(*) AS registros,
  COUNT(DISTINCT customer_id) AS clientes_unicos,
  COUNTIF(customer_id IS NULL) AS ids_nulos
FROM `SEU_PROJETO.banking_raw.dim_customer`;

-- Integridade de contratos
SELECT
  COUNT(*) AS registros,
  COUNT(DISTINCT contract_id) AS contratos_unicos,
  COUNTIF(contract_id IS NULL) AS contract_id_nulos
FROM `SEU_PROJETO.banking_raw.fact_credit_contracts`;

-- Chave composta dos snapshots
SELECT
  COUNT(*) AS registros,
  COUNT(DISTINCT STRUCT(contract_id, year_month)) AS chaves_compostas_unicas,
  COUNTIF(contract_id IS NULL OR year_month IS NULL) AS chaves_nulas
FROM `SEU_PROJETO.banking_raw.fact_credit_snapshot`;

-- Datas de atividade
SELECT year_month, COUNT(*) AS linhas
FROM `SEU_PROJETO.banking_raw.fact_customer_activity`
GROUP BY year_month
ORDER BY year_month;
