# Scripts SQL

**Adicione aqui os scripts reais executados no BigQuery** — não os recrie a partir de capturas de tela ou SQL genérico sem conferir os campos.

Sugestão de sequência de arquivos quando disponíveis:

```text
01_raw_load_notes.md       # Manifesto dos CSVs e opções de importação
02_staging_transform.sql   # Parsing/limpeza/tipagem
03_mart_financial.sql      # Fatos e dimensões de FP&A
04_mart_credit.sql         # Contratos e snapshots
05_mart_customers.sql      # Atividade e dimensões
06_quality_checks.sql     # Checks de integridade
```

O arquivo `qa_checks.sql` que acompanha o pacote contém apenas checks demonstrativos que devem ser adaptados ao nome do projeto BigQuery do leitor. Nunca versionar credenciais, tokens ou chaves de serviço.
