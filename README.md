# 🛍️ Sistema para uma Loja On Line — Cenário 6

> Projeto final da disciplina de **Ambiente de Dados (25.2)** — **Universidade de Fortaleza (UNIFOR)**  
> **Docente:** Profª. Isaura Cardoso  
> **Grupo:** Grupo 6

---

## 👥 Integrantes do Grupo 6

| Nome Completo | Papel / Contribuição |
| :--- | :--- |
| **Isabele Aragão Guerra** | Modelagem de Dados (DER/MER), Carga de Dados e Documentação |
| **Carlos Eduardo Fernandes Ribeiro Rodrigues** | Estruturação DDL, Integridade Referencial e Consultas |
| **Letícia Fermanian Gadelha** | Modelagem de Dados, Versionamento e Scripts SQL |
| **Carlos Vinícius Scipião de Paulo Vieira** | Validação de Regras de Negócio, Testes e Consultas |

---

## 📋 Visão Geral e Objetivo do Projeto

O projeto consiste na modelagem conceitual, lógica (normalizada até a **3ª Forma Normal — 3FN**) e implementação física de um banco de dados relacional em **MySQL** para atender às operações de uma loja virtual de artigos regionais (colchas de cama, bordados, artesanato, redes, mantas, couro e palha) idealizada e gerenciada por **Cristina**.

### 🎯 Para que serve o sistema?
O banco de dados centraliza e automatiza o controle operacional e gerencial do e-commerce, permitindo:
1. **Gestão de Catálogo e Estoque:** controlar características detalhadas dos produtos (tipo, cor, descrição, custo, margem de lucro), galeria de imagens (foto principal e fotos complementares) e alertas de reposição baseados em estoque mínimo alvo.
2. **Gestão de Fornecedores e Aquisições:** manter o cadastro completo de fornecedores (contatos, endereços e portfólio de itens fornecidos) e registrar cada compra realizada com data do pedido, data de recebimento, quantidades e custos unitários históricos.
3. **Gestão de Clientes e Vendas:** armazenar dados cadastrais de clientes, preferências de comunicação promocional, múltiplos endereços (com definição de endereço padrão de entrega), formas de pagamento e histórico detalhado de pedidos.
4. **Apoio à Tomada de Decisão (BI / Relatórios):** fornecer uma base consistente e volumosa para extração de indicadores comerciais, logísticos e financeiros.

---

## 🏛️ Arquitetura e Modelagem do Banco de Dados

O modelo foi projetado respeitando a **3ª Forma Normal (3FN)**, eliminando redundâncias, separando entidades associativas para relacionamentos `N:N` (como `produto_fornecedor`) e decompondo cabeçalhos e itens tanto em compras (`compra` / `item_compra`) quanto em vendas (`venda` / `item_venda`).

### Diagrama de Entidade e Relacionamento (DER)
<img width="2072" height="1137" alt="DER-GRUPO6 drawio" src="https://github.com/user-attachments/assets/a6eda738-5dc0-49fc-beec-bc2a8d232ac9" />


### Modelo de Entidade e Relacionamento (MER)
<img width="972" height="1052" alt="MER-GRUPO6 drawio" src="https://github.com/user-attachments/assets/928077b9-c077-44a4-b443-8c0969acdfa8" />


---

## 📁 Estrutura do Repositório

```text
Grupo6AmbienteDeDados/
├── DER-GRUPO6.drawio.png              # Diagrama Conceitual (Entidade e Relacionamento)
├── MER-GRUPO6.drawio.png              # Modelo Lógico Relacional (Tabelas, PKs e FKs)
├── scripts_banco/
│   ├── Bancos_GRUPO6.sql              # DDL: Criação do schema 'loja_cenario6' e das 15 tabelas
│   ├── Foreign_key_GRUPO6.sql         # DDL: Criação separada de todas as Chaves Estrangeiras (FKs)
│   ├── carga_dados_GRUPO6.sql         # DML: Massa de dados estruturada (CRUD, Mães e Movimentação)
│   └── relatorios_GRUPO6.sql          # DQL: Consultas SQL dos 6 relatórios do Cenário 6
└── README.md                          # Documentação técnica e guia de execução
```

---

## 🗄️ O que foi implementado nos Scripts

### 1. Estrutura Física (`Bancos_GRUPO6.sql` e `Foreign_key_GRUPO6.sql`)
* Criação do banco de dados `loja_cenario6` com **15 tabelas** tipadas e com chaves primárias auto-incrementais/compostas (`cliente`, `cliente_telefone`, `endereco_cliente`, `forma_pagamento`, `venda`, `item_venda`, `produto`, `foto_produto`, `produto_fornecedor`, `fornecedor`, `fornecedor_email`, `fornecedor_telefone`, `endereco_fornecedor`, `compra` e `item_compra`).
* Separação explícita entre a criação das tabelas e a aplicação das restrições de integridade referencial (`ALTER TABLE ... ADD CONSTRAINT FOREIGN KEY`), facilitando a manutenção, leitura e versionamento do esquema.

### 2. Massa de Dados (`carga_dados_GRUPO6.sql`)
Para viabilizar consultas analíticas realistas e testar todos os relatórios exigidos no cenário, o script de carga popula o banco seguindo a volumetria solicitada:
* **Tabelas CRUD / Domínio (8 a 10 registros por tabela):**
  * `forma_pagamento` (8 registros)
  * `fornecedor`, `fornecedor_email`, `fornecedor_telefone` e `endereco_fornecedor` (10 registros cada)
* **Tabelas Mães / Principais (40 a 50 registros por tabela):**
  * `produto` (40 registros, incluindo 8 SKUs com estoque abaixo do mínimo alvo para validar alertas de reposição)
  * `cliente` (45 registros)
  * `cliente_telefone`, `endereco_cliente`, `foto_produto` e `produto_fornecedor` (50 registros cada)
  * Cada item de compra é de um produto que consta no catálogo (`produto_fornecedor`) do fornecedor daquela compra.
* **Tabelas de Movimentação (1.000 registros totais):**
  * `compra` (150 registros) e `item_compra` (300 registros)
  * `venda` (200 registros) e `item_venda` (350 registros)
* **Ajuste automático de datas:** ao final da carga, as datas de vendas e compras são deslocadas para que a venda mais recente seja sempre o dia anterior à execução, preservando os intervalos entre elas (inclusive o prazo de recebimento das compras). Assim, os relatórios de "últimos 30 dias" e "últimos 12 meses" sempre retornam dados, em qualquer data em que o banco for carregado.

### 3. Relatórios (`relatorios_GRUPO6.sql`)
Contém as 6 consultas SQL exigidas pelo cenário, descritas na seção [Relatórios Gerenciais](#-relatórios-gerenciais-contemplados-pelo-cenário-6).

---

## 🚀 Tutorial: Como Executar o Projeto Passo a Passo

### Pré-requisitos
* **MySQL Server** (versão 8.0 ou superior recomendada).
* Um cliente SQL de sua preferência (**MySQL Workbench**, **DBeaver**, **VS Code** com extensão MySQL ou **Terminal/CLI**).
* **Git** instalado (para clonar o repositório).

### Passo 1: Clonar o Repositório
Abra o terminal (PowerShell, CMD ou Bash) e execute:

```bash
git clone https://github.com/Fermanian21/Grupo6AmbienteDeDados.git
cd Grupo6AmbienteDeDados
```

### Passo 2: Executar os Scripts SQL na Ordem Correta
> ⚠️ **Atenção:** A ordem de execução abaixo é obrigatória para garantir que o banco seja criado antes das tabelas, que as chaves estrangeiras referenciem tabelas já existentes e que os dados respeitem todas as restrições.

#### Opção A — Via MySQL Workbench ou DBeaver (Interface Gráfica)
1. Conecte-se à sua instância local do MySQL.
2. Abra e execute o arquivo **`scripts_banco/Bancos_GRUPO6.sql`** (cria o banco `loja_cenario6` e todas as 15 tabelas).
3. Abra e execute o arquivo **`scripts_banco/Foreign_key_GRUPO6.sql`** (vincula todas as chaves estrangeiras).
4. Abra e execute o arquivo **`scripts_banco/carga_dados_GRUPO6.sql`** (insere todos os registros nas tabelas).
5. Abra e execute o arquivo **`scripts_banco/relatorios_GRUPO6.sql`** (gera os 6 relatórios do cenário).
6. Atualize o painel de *Schemas* para visualizar o banco `loja_cenario6` populado.

#### Opção B — Via Linha de Comando (Terminal MySQL)
Na raiz do repositório, execute os comandos abaixo informando seu usuário do MySQL (ex.: `root`):

```bash
mysql -u root -p < scripts_banco/Bancos_GRUPO6.sql
mysql -u root -p < scripts_banco/Foreign_key_GRUPO6.sql
mysql -u root -p < scripts_banco/carga_dados_GRUPO6.sql
mysql -u root -p -t < scripts_banco/relatorios_GRUPO6.sql
```

### Passo 3: Validar a Carga de Dados
Para confirmar que todas as tabelas foram criadas e populadas corretamente, execute a consulta de verificação abaixo no MySQL:

```sql
USE loja_cenario6;

SELECT 'forma_pagamento' AS tabela, COUNT(*) AS total FROM forma_pagamento
UNION ALL SELECT 'fornecedor', COUNT(*) FROM fornecedor
UNION ALL SELECT 'cliente', COUNT(*) FROM cliente
UNION ALL SELECT 'produto', COUNT(*) FROM produto
UNION ALL SELECT 'compra', COUNT(*) FROM compra
UNION ALL SELECT 'item_compra', COUNT(*) FROM item_compra
UNION ALL SELECT 'venda', COUNT(*) FROM venda
UNION ALL SELECT 'item_venda', COUNT(*) FROM item_venda;
```

---

## 📊 Relatórios Gerenciais Contemplados pelo Cenário 6

As 6 consultas estratégicas definidas no escopo do trabalho estão implementadas em `scripts_banco/relatorios_GRUPO6.sql`:

1. **Vendas por Estado (Último Mês):** total de unidades vendidas e faturamento bruto (R$) nos últimos 30 dias, agrupados por estado (`UF`) do endereço de entrega.
2. **Melhores Clientes e Ticket Médio (Último Ano):** ranking dos 10 clientes com maior volume financeiro nos últimos 12 meses, exibindo valor total gasto e ticket médio por pedido.
3. **Produtos Mais Vendidos por Tipo:** volume total de unidades comercializadas e preço médio de venda praticado, agrupados por categoria (`tipo` do produto).
4. **Rentabilidade de Produtos (Custo vs. Venda):** comparativo entre custo de aquisição, preço médio de venda, lucro médio unitário (R$) e margem de lucro percentual (%).
5. **Alerta de Estoque Baixo (SKUs Críticos):** identificação de produtos com `qtd_estoque < qtd_minima_alvo`, acompanhados da data da última compra e do fornecedor principal.
6. **Análise de Desempenho de Fornecedores (Custo e Prazo):** custo médio pago pelos produtos e tempo médio de entrega (em dias entre `data_compra` e `data_recebimento`) por fornecedor.
