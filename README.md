# 🛍️ Grupo 6 — Sistema para uma Loja On Line (Cenário 6)

Repositório do **Grupo 6** referente ao trabalho final da disciplina de **Ambiente de Dados (25.2)** da **Universidade de Fortaleza (UNIFOR)**, ministrada pela **Profª. Isaura Cardoso**.

## 👥 Integrantes do Grupo 6
* **Isabele Aragão Guerra**
* **Carlos Eduardo Fernandes Ribeiro Rodrigues**
* **Letícia Fermanian Gadelha**
* **Carlos Vinícius Scipião de Paulo Vieira**

---

## 📌 Sobre o Cenário 6
O projeto modela e implementa o banco de dados de uma loja virtual voltada para a venda de artigos regionais (como colchas de cama, bordados e artesanato) gerenciada por **Cristina**. O sistema contempla:
* **Cadastro e Controle de Estoque de Produtos:** nome, descrição, tipo, cor, características, valor de custo, percentual de lucro, quantidade em estoque, quantidade mínima alvo e múltiplas fotos (foto principal e complementares).
* **Gestão de Fornecedores e Compras:** cadastro de fornecedores (nome, telefones, e-mails, endereços e itens fornecidos) e registro de compras/aquisições com data da compra, data de recebimento, quantidades e valores unitários de custo.
* **Clientes e Vendas:** cadastro de clientes (CPF, nome, telefones, preferência por mensagens promocionais e endereços com marcação de endereço padrão de entrega), formas de pagamento e registro de vendas e itens vendidos.

---

## 📁 Estrutura do Repositório

```text
Grupo6AmbienteDeDados/
├── scripts_banco/
│   ├── Bancos_GRUPO6.sql          # Criação do banco de dados e das tabelas
│   ├── Foreign_key_GRUPO6.sql     # Criação das chaves estrangeiras (FKs)
│   └── carga_dados_GRUPO6.sql     # Script de carga de dados (CRUD, tabelas mães e movimentação)
└── README.md
