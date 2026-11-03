# Arquitetura e modelagem dimensional

## Objetivo
Demonstrar uma arquitetura analítica em três camadas no Google BigQuery e consumo em Power BI, separando ingestão, preparação e publicação de tabelas analíticas.

```text
CSV sintético → banking_raw → banking_staging → banking_mart → Power BI
```

| Camada | Propósito | Exemplo |
|---|---|---|
| RAW | Preservar registros importados | `fact_credit_snapshot` |
| STAGING | Tipagem, parsing e padronização | `stg_credit_snapshot` |
| MART | Tabelas analíticas para consumo | `fact_financial_actual`, `fact_credit_snapshot` |

**Advertência:** a arquitetura acima descreve o projeto planejado/implementado em suas páginas. Os scripts efetivamente executados devem ser exportados e versionados em `sql/` para validar a reprodutibilidade. Em parte do desenvolvimento houve troubleshooting de cargas na MART; o repositório não atesta execução integral automatizada do pipeline.

## Fatos e granularidades

| Fato | Grão principal | Regra de agregação |
|---|---|---|
| `fact_financial_actual` | Mês × conta contábil × centro de custo | Somável no período |
| `fact_financial_budget` | Mês × conta contábil × centro de custo | Somável no período |
| `fact_credit_contracts` | Contrato | Concessões por data de originação |
| `fact_credit_snapshot` | Contrato × competência | **Semissomável:** nunca somar saldos de vários meses como uma única posição |
| `fact_customer_activity` | Conta × mês, em meses com atividade | Distintos por mês para MAU |

## Caminhos de filtro do Power BI

- **FP&A:** `dim_date`, `dim_gl_account`, `dim_cost_center` → duas fatos financeiras (1:N).
- **Crédito:** `dim_customer` e `dim_product` → `fact_credit_contracts` → `fact_credit_snapshot`; calendário → `fact_credit_snapshot` pelo primeiro dia da competência. Atenção a caminhos ativos ambíguos ao conectar calendário com concessões.
- **Clientes:** `dim_customer` → `dim_account` → `fact_customer_activity`; `dim_date` → `fact_customer_activity`.

Filtros preferencialmente unidirecionais da dimensão para o fato; a medida de ticket utiliza a data de originação como referência temporal de concessão.

## Boas práticas de apresentação

- Manter a data-base visível para indicadores de estoque.
- Separar medidas de **fluxo** (receita, despesa, concessões, novos clientes) de medidas de **estoque** (base acumulada, saldo de carteira, NPL no fechamento).
- Não associar os números simulados às operações de instituições reais.
