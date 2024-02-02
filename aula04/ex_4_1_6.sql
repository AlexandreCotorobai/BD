CREATE SCHEMA atlEx;
GO

CREATE TABLE atlEx.Turma
(
    ID_Turma INT NOT NULL,
    Designacao [NVARCHAR](50) NOT NULL,
    N_Max_Alunos INT NOT NULL,
    Ano_letivo INT NOT NULL,
    Escolariade INT NOT NULL,

    PRIMARY KEY (ID_Turma)
);
GO

CREATE TABLE atlEx.Pessoa
(
    CC INT NOT NULL, 
    Nome [NVARCHAR](50) NOT NULL,
    Data_Nascimento date NOT NULL,
    Morada [NVARCHAR](50) NOT NULL,
    PRIMARY KEY (CC)
);
GO


CREATE TABLE atlEx.Professor
(
    Email [NVARCHAR](50) NOT NULL,
    FK_CC INT NOT NULL,
    N_Funcionario INT NOT NULL,
    Contacto_Telefonico INT NOT NULL,

    PRIMARY KEY (FK_CC),
    FOREIGN KEY (FK_CC) REFERENCES atlEx.Pessoa(CC)
);
GO


CREATE TABLE atlEx.PessoaAutorizada
(
    EMAIL [NVARCHAR](50) NOT NULL,
    FK_CC INT NOT NULL,
    Contacto_Telefonico INT NOT NULL,

    PRIMARY KEY (FK_CC),
    FOREIGN KEY (FK_CC) REFERENCES atlEx.Pessoa(CC)
);
GO

CREATE TABLE atlEx.Aluno
(
    FK_CC INT NOT NULL,
    FK_ID_Turma INT NOT NULL,
    Relacao [NVARCHAR](50) NOT NULL,

    PRIMARY KEY (FK_CC),
    FOREIGN KEY (FK_CC) REFERENCES atlEx.Pessoa(CC),
    FOREIGN KEY (FK_ID_Turma) REFERENCES atlEx.Turma(ID_Turma),
    UNIQUE (Relacao)
);
GO


CREATE TABLE atlEx.EncarregadoDeEducacao
(
    FK_CC INT NOT NULL,
    Email [NVARCHAR](50) NOT NULL,
    Contacto_Telefonico INT NOT NULL,
    FK_Relacao [NVARCHAR](50) NOT NULL,

    PRIMARY KEY (FK_CC),
    FOREIGN KEY (FK_CC) REFERENCES atlEx.PessoaAutorizada(FK_CC),
    FOREIGN KEY (FK_Relacao) REFERENCES atlEx.Aluno(Relacao)
);
GO



CREATE TABLE atlEx.Pode_Levantar_Entregar
(
    FK_CC_Aluno INT NOT NULL,
    FK_CC_PessoaAutorizada INT NOT NULL,

    PRIMARY KEY (FK_CC_Aluno, FK_CC_PessoaAutorizada),
    FOREIGN KEY (FK_CC_Aluno) REFERENCES atlEx.Aluno(FK_CC),
    FOREIGN KEY (FK_CC_PessoaAutorizada) REFERENCES atlEx.PessoaAutorizada(FK_CC)
);
GO


CREATE TABLE atlEx.Atividade
(
    Designacao [NVARCHAR](50) NOT NULL,
    ID_Atividade INT NOT NULL,
    Custo FLOAT NOT NULL,
    FK_CC_Aluno INT NOT NULL,

    PRIMARY KEY (ID_Atividade),
    FOREIGN KEY (FK_CC_Aluno) REFERENCES atlEx.Aluno(FK_CC)
);
GO

CREATE TABLE atlEx.Tem
(
    FK_ID_Turma INT NOT NULL,
    FK_CC_Professor INT NOT NULL,

    PRIMARY KEY (FK_ID_Turma, FK_CC_Professor),
    FOREIGN KEY (FK_ID_Turma) REFERENCES atlEx.Turma(ID_Turma),
    FOREIGN KEY (FK_CC_Professor) REFERENCES atlEx.Professor(FK_CC)
);
GO

