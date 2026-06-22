CREATE TABLE IF NOT EXISTS `Cliente` (
	`idCliente` int AUTO_INCREMENT NOT NULL UNIQUE,
	`Endereço` varchar(255) NOT NULL,
	`Tipo_Cliente` varchar(255) NOT NULL,
	`Nome_Razao_Social` varchar(255) NOT NULL,
	`CPF` varchar(255),
	`CNPJ` varchar(255),
	PRIMARY KEY (`idCliente`),
	CONSTRAINT `chk_tipo_cliente` CHECK ((Tipo_Cliente = 'PF' AND CPF IS NOT NULL AND CNPJ IS NULL) OR (Tipo_Cliente = 'PJ' AND CNPJ IS NOT NULL AND CPF IS NULL))
);
CREATE TABLE IF NOT EXISTS `Pedidos` (
	`idPedido` int AUTO_INCREMENT NOT NULL UNIQUE,
	`Status_do_Pedido` varchar(255) NOT NULL COMMENT 'Padronizar valores (ex.: PENDENTE, PAGO, ENVIADO, ENTREGUE, CANCELADO).',
	`idCliente` int NOT NULL,
	`Descrição` varchar(255) NOT NULL,
	`Data_Pedido` datetime NOT NULL,
	`Valor_Total` decimal(10,2) NOT NULL DEFAULT 0,
	`Frete` decimal(10,2) NOT NULL DEFAULT 0,
	`Periodo_Carencia_Devolucao_Dias` int COMMENT 'Período de carência para devolução (em dias)',
	PRIMARY KEY (`idPedido`),
	CONSTRAINT `chk_status_do_pedido_valido` CHECK (Status_do_Pedido IN ('PENDENTE','PAGO','CANCELADO'))
);
CREATE TABLE IF NOT EXISTS `Produtos` (
	`idProduto` int AUTO_INCREMENT NOT NULL UNIQUE,
	`Categoria` varchar(255) NOT NULL,
	`Descrição` varchar(255) NOT NULL,
	`idFornecedor` int NOT NULL,
	`Valor` decimal(10,2) NOT NULL,
	PRIMARY KEY (`idProduto`)
);
CREATE TABLE IF NOT EXISTS `Fornecedor` (
	`idFornecedor` int AUTO_INCREMENT NOT NULL UNIQUE,
	`Razão_Social` varchar(255) NOT NULL,
	`CNPJ` varchar(255) NOT NULL,
	PRIMARY KEY (`idFornecedor`)
);
-- Tabela de itens do pedido (N:N entre Pedidos e Produtos).
CREATE TABLE IF NOT EXISTS `pedido_produto` (
	`idPedido` int NOT NULL,
	`idProduto` int NOT NULL,
	`Quantidade` int NOT NULL DEFAULT 1,
	`Valor_Unitario` decimal(10,2),
	CONSTRAINT `pk_pedido_produto` PRIMARY KEY (idPedido, idProduto)
) COMMENT='Tabela de itens do pedido (N:N entre Pedidos e Produtos).';
CREATE TABLE IF NOT EXISTS `Forma_Pagamento` (
	`idFormaPagamento` int AUTO_INCREMENT NOT NULL UNIQUE,
	`idCliente` int NOT NULL,
	`Tipo_Pagamento` varchar(255) NOT NULL,
	`Detalhes` varchar(255) NOT NULL,
	`Ativo` boolean NOT NULL DEFAULT true,
	PRIMARY KEY (`idFormaPagamento`)
);
CREATE TABLE IF NOT EXISTS `Entrega` (
	`idEntrega` int AUTO_INCREMENT NOT NULL UNIQUE,
	`idPedido` int NOT NULL,
	`Status_Entrega` varchar(255) NOT NULL,
	`Codigo_Rastreio` varchar(255),
	`Data_Atualizacao` datetime NOT NULL,
	PRIMARY KEY (`idEntrega`)
);
ALTER TABLE `Pedidos` ADD CONSTRAINT `Pedidos_fk2` FOREIGN KEY (`idCliente`) REFERENCES `Cliente`(`idCliente`);
ALTER TABLE `Produtos` ADD CONSTRAINT `Produtos_fk3` FOREIGN KEY (`idFornecedor`) REFERENCES `Fornecedor`(`idFornecedor`);
ALTER TABLE `pedido_produto` ADD CONSTRAINT `pedido_produto_fk0` FOREIGN KEY (`idPedido`) REFERENCES `Pedidos`(`idPedido`);
ALTER TABLE `pedido_produto` ADD CONSTRAINT `pedido_produto_fk1` FOREIGN KEY (`idProduto`) REFERENCES `Produtos`(`idProduto`);
ALTER TABLE `Forma_Pagamento` ADD CONSTRAINT `Forma_Pagamento_fk1` FOREIGN KEY (`idCliente`) REFERENCES `Cliente`(`idCliente`);
ALTER TABLE `Entrega` ADD CONSTRAINT `Entrega_fk1` FOREIGN KEY (`idPedido`) REFERENCES `Pedidos`(`idPedido`);
CREATE INDEX `idx_pedidos_idCliente` USING BTREE ON `Pedidos` (`idCliente`);
CREATE INDEX `idx_pedidos_status` USING BTREE ON `Pedidos` (`Status_do_Pedido`);
CREATE INDEX `idx_pedido_produto` USING BTREE ON `pedido_produto` (`idPedido`, `idProduto`);
CREATE UNIQUE INDEX `uq_pedido_produto` USING BTREE ON `pedido_produto` (`idPedido`, `idProduto`);
CREATE INDEX `idx_pedido_produto_idPedido` USING BTREE ON `pedido_produto` (`idPedido`);
CREATE INDEX `idx_pedido_produto_idProduto` USING BTREE ON `pedido_produto` (`idProduto`);
CREATE INDEX `idx_entrega_pedido` USING BTREE ON `Entrega` (`idPedido`);