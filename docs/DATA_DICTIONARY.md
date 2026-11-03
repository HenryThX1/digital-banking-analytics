# Dicionário de dados — tabelas principais

> Estrutura baseada nos campos observados durante o desenvolvimento. Confira as exportações antes de anunciar cobertura total do esquema. Campos do tipo data na MART podem ter nomes adicionais derivados das transformações.

## Dimensões

| Tabela | Campos observados | Papel |
|---|---|---|
| `dim_date` | `date_id`, `full_date`, `year`, `quarter`, `month`, `year_month` | Calendário |
| `dim_customer` | `customer_id`, `onboarding_date`, `state`, `segment`, `age_at_generation` | Perfil sintético |
| `dim_account` | `account_id`, `customer_id`, `opened_date`, `account_type`, `status` | Vinculação conta → cliente |
| `dim_product` | `product_id`, `product_name`, `category` | Produto |
| `dim_gl_account` | `gl_account_id`, `gl_account_name`, `account_type` | Plano de contas gerencial |
| `dim_cost_center` | `cost_center_id`, `cost_center_name` | Centro de custo |

## Fatos

| Tabela | Campos observados | Grão |
|---|---|---|
| `fact_financial_actual` | `year_month`, `gl_account_id`, `cost_center_id`, `amount_brl` | Mês × GL × CC |
| `fact_financial_budget` | `year_month`, `gl_account_id`, `cost_center_id`, `amount_brl` | Mês × GL × CC |
| `fact_credit_contracts` | `contract_id`, `customer_id`, `origination_date_id`, `product_id`, `principal_brl`, `term_months`, `monthly_rate`, `scheduled_payment_brl` | Contrato |
| `fact_credit_snapshot` | `contract_id`, `year_month`, `snapshot_date` (MART), `outstanding_principal_brl`, `days_past_due`, `accrued_interest_brl`, `principal_paid_brl` | Contrato × mês |
| `fact_customer_activity` | `account_id`, `year_month` (RAW), `month_date` (MART), `transaction_count` | Conta × mês |

## Valores e convenções

- Moeda: BRL (reais).
- Período analítico representado nos dashboards: 2024–2025.
- `snapshot_date` e `month_date` derivam de `year_month` no formato `YYYY-MM`, utilizando primeiro dia do mês para relacionamento.
- Saldos e taxas se referem à competência; não são movimentações acumuláveis através de vários meses.
- `account_type` em `dim_gl_account` diferencia REVENUE e EXPENSE; o valor financeiro é tratado como magnitude positiva e o resultado gerencial é calculado subtraindo despesas.

**Dicionário completo com tipos, nulos e exemplos:** a publicar junto aos CSVs definitivos e ao esquema exportado do BigQuery.
