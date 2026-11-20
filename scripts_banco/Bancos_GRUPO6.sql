create database loja_cenario6;
use loja_cenario6;

create table cliente (
	id_cliente int not null auto_increment,
    nome varchar(100) not null,
	cpf varchar(14) not null,
    deseja_promocao char(1) not null,
    primary key (id_cliente)
);

create table fornecedor (
	id_fornecedor int not null auto_increment,
    nome varchar(100) not null,
    primary key (id_fornecedor)
);

create table forma_pagamento (
	id_forma_pagamento int not null auto_increment,
    descricao varchar(100) not null,
    primary key (id_forma_pagamento)
);

create table produto (
    id_produto int not null auto_increment,
    nome varchar(100) not null,
    descricao varchar(255) not null,
    tipo varchar(50) not null,
    cor varchar(50) not null,
    caracteristicas text not null,
    valor_custo decimal(10,2) not null,
    percentual_lucro decimal(5,2) not null,
    qtd_estoque int not null,
    qtd_minima_alvo int not null,
    primary key (id_produto)
);

create table cliente_telefone (
    id_telefone int not null auto_increment,
    numero varchar(20) not null,
    id_cliente int not null,
    primary key (id_telefone)
);

create table endereco_cliente (
    id_endereco int not null auto_increment,
    id_cliente int not null,
    logradouro varchar(255) not null,
    numero varchar(20) not null,
    bairro varchar(100) not null,
    cidade varchar(100) not null,
    estado char(2) not null,
    cep varchar(10) not null,
    padrao_entrega char(1) not null,
    primary key (id_endereco)
);

create table venda (
	id_venda int not null auto_increment,
    data_venda date not null,
    id_cliente int not null,
    id_forma_pagamento int not null,
    id_endereco int not null,
    primary key (id_venda)
);

create table item_venda (
	id_item_venda int not null auto_increment,
    preco_unitario_venda decimal(10,2) not null,
    quantidade int not null,
    id_venda int not null,
    id_produto int not null,
    primary key (id_item_venda)
);

create table foto_produto (
    id_foto_produto int not null auto_increment,
    id_produto int not null,
    caminho_arquivo varchar(255) not null,
    foto_principal char(1) not null,
    primary key (id_foto_produto)
);

create table fornecedor_email (
    id_email int not null auto_increment,
    id_fornecedor int not null,
    email varchar(100) not null,
    primary key (id_email)
);

create table fornecedor_telefone (
    id_telefone int not null auto_increment,
    id_fornecedor int not null,
    numero varchar(20) not null,
    primary key (id_telefone)
);

create table compra (
	id_compra int not null auto_increment,
	id_fornecedor int not null,
    data_compra date not null,
    data_recebimento date,
    primary key(id_compra)
);

create table produto_fornecedor (
    id_produto int not null,
    id_fornecedor int not null,
    primary key (id_produto, id_fornecedor)
);

create table endereco_fornecedor (
    id_endereco_fornecedor int not null auto_increment,
    id_fornecedor int not null,
    logradouro varchar(255) not null,
    numero varchar(20) not null,
    bairro varchar(100) not null,
    cidade varchar(100) not null,
    estado char(2) not null,
    cep varchar(10) not null,
    primary key (id_endereco_fornecedor)
);

create table item_compra (
    id_item_compra int not null auto_increment,
    id_compra int not null,
    id_produto int not null,
    valor_unitario_custo decimal(10,2) not null,
    quantidade int not null,
    primary key (id_item_compra)
);