use loja_cenario6;

alter table cliente_telefone
add constraint fk_cliente_telefone
foreign key (id_cliente) references cliente(id_cliente);

alter table endereco_cliente
add constraint fk_endereco_cliente
foreign key (id_cliente) references cliente(id_cliente);

alter table venda
add constraint fk_venda_cliente
foreign key (id_cliente) references cliente(id_cliente),
add constraint fk_venda_forma_pagamento
foreign key (id_forma_pagamento) references forma_pagamento(id_forma_pagamento),
add constraint fk_venda_endereco
foreign key (id_endereco) references endereco_cliente(id_endereco);

alter table item_venda
add constraint fk_item_venda_venda
foreign key (id_venda) references venda(id_venda),
add constraint fk_item_venda_produto
foreign key (id_produto) references produto(id_produto);

alter table foto_produto
add constraint fk_foto_produto
foreign key (id_produto) references produto(id_produto);

alter table fornecedor_email
add constraint fk_fornecedor_email
foreign key (id_fornecedor) references fornecedor(id_fornecedor);

alter table fornecedor_telefone
add constraint fk_fornecedor_telefone
foreign key (id_fornecedor) references fornecedor(id_fornecedor);

alter table compra
add constraint fk_compra_fornecedor
foreign key (id_fornecedor) references fornecedor(id_fornecedor);

alter table produto_fornecedor
add constraint fk_produto_fornecedor_prod
foreign key (id_produto) references produto(id_produto),
add constraint fk_produto_fornecedor_forn
foreign key (id_fornecedor) references fornecedor(id_fornecedor);

alter table endereco_fornecedor
add constraint fk_endereco_fornecedor
foreign key (id_fornecedor) references fornecedor(id_fornecedor);

alter table item_compra
add constraint fk_item_compra_compra
foreign key (id_compra) references compra(id_compra),
add constraint fk_item_compra_produto
foreign key (id_produto) references produto(id_produto);