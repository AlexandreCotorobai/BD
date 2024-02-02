CREATE SCHEMA medi;
GO

CREATE TABLE medi.medico(
    nome_medico VARCHAR(50) NOT NULL,
    sns INTEGER NOT NULL,
    especialidade VARCHAR(50) NOT NULL,

    PRIMARY KEY (sns),
    UNIQUE (nome_medico)
);
GO

CREATE TABLE medi.paciente(
    utente INTEGER NOT NULL,
    nome_paciente VARCHAR(50) NOT NULL,
    endereco VARCHAR(50) NOT NULL,
    data_nascimento DATETIME NOT NULL,

    PRIMARY KEY (utente)
);
GO

CREATE TABLE medi.farmacia(
    nif INTEGER NOT NULL,
    nome_farmacia VARCHAR(50) NOT NULL,
    telefone INTEGER NOT NULL,
    endereco VARCHAR(50) NOT NULL,

    PRIMARY KEY (nif),
    UNIQUE (nome_farmacia)
);
GO

CREATE TABLE medi.farmaceutica(
    telefone INTEGER NOT NULL,
    registo_nacional INTEGER NOT NULL,
    nome VARCHAR(50) NOT NULL,
    endereco VARCHAR(50) NOT NULL,

    PRIMARY KEY (registo_nacional),
    UNIQUE (nome)
);
GO

CREATE TABLE medi.prescricao(
    numero INTEGER NOT NULL,
    data DATETIME NOT NULL,
    data_process VARCHAR(50) NOT NULL,
    fk_nif INTEGER NOT NULL,
    fk_nome_farmacia VARCHAR(50) NOT NULL,
    fk_nome_medico VARCHAR(50) NOT NULL,
    fk_sns INTEGER NOT NULL,
    fk_utente INTEGER NOT NULL,

    PRIMARY KEY (numero),
    FOREIGN KEY (fk_nif) REFERENCES medi.farmacia(nif),
    FOREIGN KEY (fk_nome_farmacia) REFERENCES medi.farmacia(nome_farmacia),
    FOREIGN KEY (fk_nome_medico) REFERENCES medi.medico(nome_medico),	
    FOREIGN KEY (fk_sns) REFERENCES medi.medico(sns),
    FOREIGN KEY (fk_utente) REFERENCES medi.paciente(utente)
);
GO


CREATE TABLE medi.farmaco(
    nome_comercial VARCHAR(50) NOT NULL,
    formula VARCHAR(50) NOT NULL,
    nome_unico VARCHAR(50) NOT NULL,
    fk_registo_nacional INTEGER NOT NULL,
    fk_nome VARCHAR(50) NOT NULL,
    fk_nif INTEGER NOT NULL,
    fk_nome_farmacia VARCHAR(50) NOT NULL

    PRIMARY KEY (nome_unico),
    FOREIGN KEY (fk_registo_nacional) REFERENCES medi.farmaceutica(registo_nacional),
    FOREIGN KEY (fk_nome) REFERENCES medi.farmaceutica(nome),
    FOREIGN KEY (fk_nif) REFERENCES medi.farmacia(nif),
    FOREIGN KEY (fk_nome_farmacia) REFERENCES medi.farmacia(nome_farmacia)
);
GO
