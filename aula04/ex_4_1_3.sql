
CREATE TABLE produto (
    codigo_produto INTEGER NOT NULL,
    nome VARCHAR(50) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    iva DECIMAL(10,2) NOT NULL,
    unidades INTEGER NOT NULL,

    PRIMARY KEY (codigo_produto)
);
GO

CREATE TABLE TipoFornecedor (
    designacao VARCHAR(50) NOT NULL,

    PRIMARY KEY (designacao)
);
GO

CREATE TABLE fornecedor (
    nome VARCHAR(50) NOT NULL,
    nif INTEGER NOT NULL,
    endereco VARCHAR(50) NOT NULL,
    FAX INTEGER NOT NULL,
    cond_pagamento VARCHAR(50) NOT NULL,
    fk_designacao VARCHAR(50) NOT NULL,
    codigo_interno INTEGER NOT NULL,

    PRIMARY KEY (nif),
    UNIQUE (nome),
    FOREIGN KEY (fk_designacao) REFERENCES TipoFornecedor(designacao)
);
GO

CREATE TABLE encomenda (
    codigo_encomenda INTEGER NOT NULL,
    data_encomenda DATETIME NOT NULL,
    unidades INTEGER NOT NULL,
    fk_codigo_produto INTEGER NOT NULL,
    fk_nif INTEGER NOT NULL,
    fk_nome VARCHAR(50) NOT NULL,

    PRIMARY KEY (codigo_encomenda),
    FOREIGN KEY (fk_codigo_produto) REFERENCES produto(codigo_produto),
    FOREIGN KEy (fk_nif) REFERENCES fornecedor(nif),
    FOREIGN KEY (fk_nome) REFERENCES fornecedor(nome)
);
