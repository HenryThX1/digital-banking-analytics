# Dicionário de indicadores

| Indicador | Regra gerencial implementada/prevista | Cuidados |
|---|---|---|
| Receita Realizada | Soma de valores em contas `REVENUE` na fato actual | Fluxo do período |
| Despesa Realizada | Soma de valores em contas `EXPENSE` na fato actual | Fluxo do período |
| Resultado Realizado | Receita − Despesa | Não confundir com soma da matriz por GL |
| Margem Gerencial % | Resultado / Receita | Taxa relativa |
| Variação YoY % | (Realizado do ano − realizado ano anterior) / ano anterior | Exibir somente quando há comparação válida com ano anterior |
| Margem YoY p.p. | (Margem atual − margem do ano anterior) × 100 | Formato numérico, unidade pontos percentuais |
| Ticket Médio de Concessão | Média de `principal_brl` dos contratos cuja data de originação cai no período | Não representa saldo médio e não deve usar data do snapshot |
| Saldo Devedor | Soma de `outstanding_principal_brl` na última competência selecionada | Estoque semissomável |
| Contratos Ativos | Contratos distintos com saldo devedor positivo na última competência | Não é total de concessões |
| Saldo NPL 90+ | Saldo devedor em contratos com `days_past_due > 90` na última competência | Base de cálculo: saldo da carteira |
| NPL 90+ % | Saldo NPL 90+ / Saldo Devedor | Pode ser 0 se houver snapshots sem atrasos >90; não confundir com ausência de dados |
| Base Acumulada | Clientes com `onboarding_date` até a última data de filtro | Estoque |
| Novos Clientes no Período | Cadastros com `onboarding_date` dentro do intervalo filtrado | Fluxo |
| Clientes Ativos (MAU) | Conta distinta com `transaction_count > 0` no mês da data-base; equivale a cliente sob hipótese 1:1 | Métrica de atividade transacional, não qualquer login |
| Taxa de Atividade Mensal | MAU / Base acumulada | Mesmo mês de referência |
| Retenção Mensal M/M | Contas ativas em M−1 e M / contas ativas em M−1 | M/M não é retenção anual por coorte |

## Observações contábeis

- O `Total` aditivo da matriz de contas contábeis pode corresponder à soma de receitas e despesas em magnitudes positivas; esse total **não é lucro**.
- Desvio por conta (`Actual - Budget`) tem sinal diferente do efeito no resultado para contas de despesa (efeito gerencial costuma usar sinal invertido).
- Não existe conciliação integral demonstrada entre a carteira de crédito (snapshots) e as contas de receita de juros, despesa de provisões e resultado gerencial de FP&A.
- Não representar estes indicadores como números oficiais do Banco Inter ou como demonstrações financeiras auditadas.
