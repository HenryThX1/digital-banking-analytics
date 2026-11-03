# Digital Banking Analytics | BigQuery + Power BI

> **Projeto autoral e independente de Business Intelligence. Todas as informações são sintéticas.** Este projeto simula desafios de analytics de uma instituição financeira digital, **sem vínculo, endosso ou participação do Banco Inter ou de qualquer outro banco**.

## Visão geral

Portfólio de BI bancário desenvolvido para explorar três perspectivas complementares de negócio: **planejamento e desempenho financeiro (FP&A)**, **carteira de crédito e risco** e **inteligência de clientes**. O objetivo é demonstrar estruturação de dados, preparação analítica em SQL/BigQuery, modelagem dimensional, medidas DAX, visualização e comunicação de insights gerenciais.

O projeto foi construído com apoio do **ChatGPT Plus na ideação e geração de bases sintéticas**, seguido de importação, preparação e exploração no **Google BigQuery (SQL)** e desenvolvimento analítico no **Microsoft Power BI (DAX / Power Query)**. Os dados não refletem operações de uma instituição real.

### Stack

- **Geração de dados:** ChatGPT Plus (dados e regras de negócio sintéticos)
- **Armazenamento e transformação:** Google BigQuery / SQL
- **Modelagem e BI:** Power BI, Power Query, DAX
- **Versionamento e divulgação:** GitHub

## Páginas do dashboard

### 01 · FP&A | Financial Performance

Receita e despesa realizada, resultado gerencial, margem, realizado vs. orçamento e impactos por conta contábil.

![Visão FP&A](assets/screenshots/fpa.png)

### 02 · Credit Portfolio & Risk Analytics

Saldo devedor, contratos com saldo ativo, ticket médio de concessão, saldo inadimplente e taxa NPL 90+, evolução mensal da carteira e análise de concentração/atrasos.

![Visão Crédito](assets/screenshots/credit.png)

### 03 · Customer Analytics & Intelligence

Base acumulada, novos clientes, clientes ativos (MAU), taxa de atividade, retenção mensal e composição por segmento.

![Visão Clientes](assets/screenshots/customer.png)

> **Antes de publicar:** inclua capturas atualizadas e com identidade autoral nos arquivos acima. As imagens não acompanham este pacote porque ainda utilizam a marca oficial de uma instituição real.

## Arquitetura de dados

```text
Dados sintéticos (CSVs)
         ↓
BigQuery · banking_raw        (ingestão / preservação da origem)
         ↓
BigQuery · banking_staging    (tipos, datas e padronizações)
         ↓
BigQuery · banking_mart       (dimensões e fatos analíticas)
         ↓
Power BI · modelo semântico   (relacionamentos e DAX)
         ↓
Visões executivas interativas
```

As bases são organizadas em **dimensões** (calendário, clientes, contas, produtos, contas contábeis, centros de custo etc.) e **fatos** (realizado, orçamento, contratos, snapshots de crédito, atividade mensal). Consulte [Arquitetura e Modelagem](docs/ARCHITECTURE.md) e [Dicionário de Dados](docs/DATA_DICTIONARY.md).

## Indicadores e regras de negócio

| Indicador | Definição simplificada | Referência temporal |
|---|---|---|
| Resultado gerencial | Receita realizada − despesa realizada | Período selecionado |
| Margem gerencial | Resultado gerencial / receita realizada | Período selecionado |
| YoY | Variação vs. mesmo período do ano anterior | Comparação anual válida |
| Saldo de crédito | Soma do principal devedor | **Último snapshot** do contexto |
| NPL 90+ | Principal com `days_past_due > 90` / saldo de crédito | **Último snapshot** |
| Ticket médio de concessão | Média do principal original dos contratos **originados** no período | Data de originação |
| Base acumulada | Clientes cadastrados até a data-base | Última data selecionada |
| MAU | Clientes/contas com ao menos uma transação no mês, sob hipótese de uma conta por cliente | Mês de referência |
| Taxa de atividade | MAU / base acumulada | Mês de referência |
| Retenção M/M | Ativos no mês anterior que permaneceram ativos no mês atual / ativos no mês anterior | Comparação entre dois meses |

Definições completas e limitações em [Dicionário de KPIs](docs/KPI_DICTIONARY.md).

## Observações sobre os resultados demonstrativos

No fim da série sintética (dezembro de 2025), as telas exibiam aproximadamente 100 mil clientes acumulados, 74 mil ativos mensais, R$ 466 milhões de saldo de crédito e NPL 90+ de 3,20%. **São saídas de uma simulação e não informações reais do mercado.** Valores podem mudar com filtros, formatação e revisões do modelo.

## Dados sintéticos para estudo

Pretendo disponibilizar as bases e documentação para fins educacionais, de modo que outras pessoas possam praticar SQL, modelagem dimensional, DAX e Power BI. Confira [Como obter e usar os dados](data/README.md).

**Estado do pacote:** o pacote inicial **não inclui os CSVs originais, o PBIX nem os scripts efetivamente executados no BigQuery**. Esses arquivos devem ser adicionados somente após conferência, exportação e anonimização de conexões/credenciais. Não se trata, ainda, de um projeto reproduzível de ponta a ponta.

## Organização do repositório

```text
digital-banking-analytics/
├── README.md
├── docs/
│   ├── ARCHITECTURE.md
│   ├── DATA_DICTIONARY.md
│   └── KPI_DICTIONARY.md
├── sql/
│   ├── README.md
│   └── qa_checks.sql
├── data/
│   ├── README.md
│   └── sample/
├── powerbi/
│   └── README.md
└── assets/
    └── screenshots/
```

## Como explorar

1. Leia o [Dicionário de Dados](docs/DATA_DICTIONARY.md) e o [Dicionário de KPIs](docs/KPI_DICTIONARY.md).
2. Quando publicados, baixe os CSVs ou a amostra documentada em `data/`.
3. Importe-os em datasets do BigQuery nas camadas `raw`, `staging` e `mart`, executando os scripts SQL versionados **quando disponibilizados**.
4. Abra o PBIX, **quando disponibilizado**, e ajuste as fontes de dados para seu próprio ambiente; nunca utilize credenciais do autor.
5. Explore os filtros temporais e as três páginas de negócio.

## Limitações e responsabilidade metodológica

- **100% sintético:** os números, clientes, empréstimos, transações e resultados são simulados.
- **Sem reconciliação contábil completa:** não há conciliação validada entre a carteira de crédito, as receitas de juros, as despesas de provisão e o resultado de FP&A. Os três domínios não representam um balanço oficial nem uma DRE auditada.
- **Matriz de FP&A:** a soma de montantes de receitas e despesas (ambos positivos na base) **não equivale** ao resultado gerencial. Diferença por conta contábil e impacto no resultado também têm convenções de sinais distintas.
- **Data de estoque vs. fluxo:** saldos e NPL consideram a posição da última competência; receitas/despesas e novos clientes são movimentos de um período.
- **Retenção:** calculada pela interseção de contas ativas entre meses consecutivos, sob a premissa de uma conta por cliente na simulação.
- **Risco:** NPL e demais métricas são ilustrações gerenciais, não classificações regulatórias oficiais.
- **Amostras, scripts e arquivos PBIX:** a reprodutibilidade total depende de disponibilizar os artefatos originais e suas versões.

## Uso e licença

Conteúdo criado para fins educacionais e de portfólio. Antes de permitir reutilização e redistribuição dos dados e códigos, selecionar e incluir uma licença adequada ao escopo desejado. **Marcas e logotipos de terceiros não fazem parte da licença dos dados sintéticos.**
