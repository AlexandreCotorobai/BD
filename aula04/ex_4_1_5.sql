CREATE SCHEMA confer;
GO


CREATE TABLE confer.conferencia(
    nome_conferencia VARCHAR(50) NOT NULL,

    PRIMARY KEY (nome_conferencia)
);
GO

CREATE TABLE confer.instituicao(
    nome_inst VARCHAR(50) NOT NULL,
    morada_inst VARCHAR(50) NOT NULL,

    PRIMARY KEY (nome_inst)
);
GO

CREATE TABLE confer.participante(
    email_participante VARCHAR(50) NOT NULL,
    nome_participante VARCHAR(50) NOT NULL,
    morada VARCHAR(50) NOT NULL,
    fk_nome_inst VARCHAR(50) NOT NULL,
    data_inscricao DATETIME NOT NULL,
    FK_nome_conferencia VARCHAR(50) NOT NULL,

    PRIMARY KEY (email_participante),
    UNIQUE (nome_participante),

    FOREIGN KEY (fk_nome_inst) REFERENCES confer.instituicao(nome_inst),
    FOREIGN KEY (FK_nome_conferencia) REFERENCES confer.conferencia(nome_conferencia)
);
GO

CREATE TABLE confer.artigo(
    titulo  VARCHAR(50) NOT NULL,
    nr_registo INTEGER NOT NULL,
    fk_nome_conferencia VARCHAR(50) NOT NULL,

    PRIMARY KEY (nr_registo),

    FOREIGN KEY (fk_nome_conferencia) REFERENCES confer.conferencia(nome_conferencia)
);
GO



CREATE TABLE confer.autor(
    nome_autor VARCHAR(50) NOT NULL,
    email_autor VARCHAR(50) NOT NULL,
    fk_nome_inst VARCHAR(50) NOT NULL,

    PRIMARY KEY (nome_autor),

    FOREIGN KEY (fk_nome_inst) REFERENCES confer.instituicao(nome_inst)
);
GO

CREATE TABLE confer.possui(
    fk_numero_registo INTEGER NOT NULL,
    fk_nome_autor VARCHAR(50) NOT NULL,

    PRIMARY KEY (fk_numero_registo, fk_nome_autor),

    FOREIGN KEY (fk_numero_registo) REFERENCES confer.artigo(nr_registo),
    FOREIGN KEY (fk_nome_autor) REFERENCES confer.autor(nome_autor)
);
GO

CREATE TABLE confer.comprovativo(
    fk_nome_inst VARCHAR(50) NOT NULL,
    localizacao VARCHAR(50) NOT NULL,
    fk_email_participante VARCHAR(50) NOT NULL,
    fk_nome_participante VARCHAR(50) NOT NULL,

    PRIMARY KEY (fk_nome_inst, fk_email_participante),

    FOREIGN KEY (fk_nome_inst) REFERENCES confer.instituicao(nome_inst),
    FOREIGN KEY (fk_email_participante) REFERENCES confer.participante(email_participante),
    FOREIGN KEY (fk_nome_participante) REFERENCES confer.participante(nome_participante)

);
GO

CREATE TABLE confer.nao_estudante(
    fk_email_participante VARCHAR(50) NOT NULL,
    fk_nome_participante VARCHAR(50) NOT NULL,
    referencia_transacao INTEGER NOT NULL,

    PRIMARY KEY (fk_email_participante),

    FOREIGN KEY (fk_email_participante) REFERENCES confer.participante(email_participante),
    FOREIGN KEY (fk_nome_participante) REFERENCES confer.participante(nome_participante)
);
GO

CREATE TABLE confer.estudante(
    fk_email_participante VARCHAR(50) NOT NULL,
    fk_nome_participante VARCHAR(50) NOT NULL,

    PRIMARY KEY (fk_email_participante),

    FOREIGN KEY (fk_email_participante) REFERENCES confer.participante(email_participante),
    FOREIGN KEY (fk_nome_participante) REFERENCES confer.participante(nome_participante)
);
GO