CREATE DATABASE farmaceprime_solution;

USE farmaceprime_solution;


CREATE TABLE fornecedores (
  FornecedorID INT AUTO_INCREMENT PRIMARY KEY,
  Nome varchar(100) NOT NULL,
  Telefone int(9) NOT NULL unique,
  Email varchar(100) NOT NULL unique,
  Nif int(10) NOT NULL unique,
  Endereco varchar(30) NOT NULL,
  Iban int(21) DEFAULT NULL unique
);


CREATE TABLE funcionario (
   FuncionarioID INT AUTO_INCREMENT PRIMARY KEY,
   Cargo varchar(50) NOT NULL,
   Nome varchar(50) NOT NULL,
   Data_Nascimento varchar(100) NOT NULL,
   Telefone int(9) NOT NULL unique,
   Email varchar(50) NOT NULL unique,
   Iban int(21) NOT NULL unique,
   Bi varchar(15) NOT NULL unique,
   Morada varchar(100) NOT NULL,
   Data_Contratacao varchar(100) NOT NULL,
   Salario decimal(10,2) DEFAULT NULL,
   Senha varchar(50) NOT NULL,
   Genero varchar(50) NOT NULL
);

CREATE TABLE produtos(
   ProdutoID INT AUTO_INCREMENT PRIMARY KEY,
   Produto varchar(100) NOT NULL unique,
   Fabricante varchar(100) NOT NULL ,
   Data_Expiracao varchar(50) NOT NULL,
   Data_Fabricacao varchar(50) NOT NULL,
   Fornecedor varchar(100) NOT NULL unique,
   Data_Compra varchar(50) NOT NULL,
   Preco_compra decimal(10,2) NOT NULL,
   Preco_Venda_Unitario decimal(10,2) NOT NULL,
   N_Fatura int(11) NOT NULL unique,
   Quantidade int(11) NOT NULL,
   Categoria varchar(30) NOT NULL,
   Valor_Aquisicao decimal(10,2) NOT NULL,
   Percentagem_lucro int(11) NOT NULL,
   Encargo_Adicionais decimal(10,2) NOT NULL,
   Valor_Margem_Lucro decimal(10,2) NOT NULL,
   Valor_venda decimal(10,2) NOT NULL,
   Total decimal(10,2) NOT NULL
);


CREATE TABLE gestao_estoque(
    EstoqueID INT AUTO_INCREMENT PRIMARY KEY,
    ProdutoID INT not null ,
    Tipo_Movimento enum('entrada','saida') NOT NULL,
    DataMovimento date NOT NULL,
    quantidade INT,
    FOREIGN KEY (ProdutoID) REFERENCES produtos(ProdutoID)
);


CREATE TABLE vendas (
    VendaID INT AUTO_INCREMENT PRIMARY KEY,
    id_funcionario INT,
    DataVenda datetime NOT NULL,
    Quantidade int NOT NULL,
    ValorTotal decimal(10,2) NOT NULL,
    FOREIGN KEY (ProdutoID) REFERENCES produtos (ProdutoID),
    FOREIGN KEY (ClienteID) REFERENCES clientes (ClienteID),
    FOREIGN KEY (FuncionarioID) REFERENCES Funcionario(FuncionarioID)
);


CREATE TABLE Venda_Produto (
    id_venda INT,
     ProdutoID INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    PRIMARY KEY (id_venda, id_produto),
    FOREIGN KEY (id_venda) REFERENCES Venda(id_venda),
    FOREIGN KEY (ProdutoID) REFERENCES Produto(ProdutoID)
);


CREATE TABLE ajustes (
    AjusteID INT AUTO_INCREMENT PRIMARY KEY,
    ProdutoID INT,
    TipoAjuste enum('positivo','negativo') NOT NULL,
    DataAjuste date NOT NULL,
    Quantidade int(11) NOT NULL,
    FOREIGN KEY (ProdutoID) REFERENCES Produto(ProdutoID)
    );


CREATE TABLE clientes(
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,
    Nome varchar(100) NOT NULL,
   Email varchar(100) DEFAULT NULL unique,
   Telefoneva varchar(20) DEFAULT NULL unique,
   Endereco varchar(255) DEFAULT NULL
);


CREATE TABLE Farmacia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Nome varchar(100) NOT NULL,
    Email varchar(100) not null unique,
    Telefone varchar(15) not null unique,
    Endereco varchar(100) not null
);


CREATE TABLE Pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_funcionario int not null,
    valor decimal(10,2)not null,
    data_pagameto varchar(50)not null,
    estado enum('pago','não pago')not null,
    forma_pagamento varchar(60) not null,
    FOREIGN KEY (FuncionarioID) REFERENCES Funcionario(FuncionarioID)
);
create table Fatura(
   FaturaID int(11) NOT NULL AUTO_INCREMENT,
   id_venda int(11) DEFAULT NULL,
   DataFatura datetime NOT NULL,
   ValorTotal decimal(10,2) NOT NULL,
  MetodoPagamento varchar(50) NOT NULL,
  FOREIGN KEY (id_venda) REFERENCES Venda(id_venda)
);
create table devolucao(
   DevolucaoID int(11) NOT NULL AUTO_INCREMENT,
   FaturaID int(11) NOT NULL,
   ProdutoID int(11) NOT NULL,
   Quantidade int(11) NOT NULL,
   DataDevolucao datetime NOT NULL,
   Motivo varchar(255) DEFAULT NULL,
   FOREIGN KEY (FaturaID) REFERENCES fatura (FaturaID),
   FOREIGN KEY (ProdutoID) REFERENCES produtos (ProdutoID)
);
