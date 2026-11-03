# Bases sintéticas para prática

## Estado atual
Os CSVs originais ainda precisam ser adicionados. Este pacote de documentação **não contém dados reais nem uma cópia dos arquivos sintéticos produzidos anteriormente**. Evite declarar o dataset como disponível até publicar um arquivo verificável.

## Manifesto sugerido (publicar só após conferir)

- `dim_customer.csv`, `dim_account.csv`, `dim_date.csv`, `dim_product.csv`
- `dim_gl_account.csv`, `dim_cost_center.csv`, `dim_channel.csv`
- `fact_financial_actual.csv`, `fact_financial_budget.csv`
- `fact_credit_contracts.csv`, `fact_credit_snapshot.csv`
- `fact_customer_activity.csv`, `fact_transactions.csv`

## Compartilhamento responsável

1. Conferir que são dados **integralmente fictícios**; não misturar exportações de trabalho ou reais.
2. Validar arquivo, tamanho, colunas, cabeçalho UTF-8, formato de datas e separador CSV.
3. Incluir dicionário, período, quantidade de linhas, regra de grão e, se disponível, seed e prompt de geração.
4. Disponibilizar uma amostra pequena em `sample/` e, se muito grande, um arquivo ZIP em **GitHub Releases** ou em repositório de dados específico.
5. Documentar como usar as tabelas no BigQuery e as limitações da consistência simulada.

### Exemplo de instrução para leitura

Amostra de registros sintéticos em CSV. Todas as chaves e informações são fictícias. O objetivo é treinamento de modelagem, SQL, Data Quality, BI, DAX e análise bancária. O dataset não é regulatório nem representa operações reais.
