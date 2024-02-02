create schema rentacar;
go

create table rentacar.balcao(
    numero int identity(1,1),
    nome NVARCHAR(50) not null,
    endereco NVARCHAR(50) not null,
    primary key (numero)
);
go

create table rentacar.cliente(
    nif int,
    nome NVARCHAR(50) not null,
    endereco NVARCHAR(50) not null,
    num_carta int not null,
    primary key (nif),
    unique (num_carta)
);
go

create table rentacar.tipo_veiculo(
    codigo int,
    arcondicionado bit not null,
    primary key (codigo)
);
go

create table rentacar.similaridade(
    FK_codigo1 int,
    FK_codigo2 int,
    primary key (FK_codigo1, FK_codigo2),
    foreign key (FK_codigo1) references rentacar.tipo_veiculo(codigo),
    foreign key (FK_codigo2) references rentacar.tipo_veiculo(codigo)
);
go

create table rentacar.ligeiro(
    FK_codigo int,
    peso float not null,
    passageiros int not null,
    primary key (FK_codigo),
    foreign key (FK_codigo) references rentacar.tipo_veiculo(codigo)
);
go

create table rentacar.pesado(
    FK_codigo int,
    combustivel NVARCHAR(50) not null,
    portas int not null,
    numlugares int not null,    
    primary key (FK_codigo),
    foreign key (FK_codigo) references rentacar.tipo_veiculo(codigo)
);
go

create table rentacar.veiculo(
    matricula NVARCHAR(6),
    FK_codigo int,
    ano int not null,
    marca NVARCHAR(50) not null,
    primary key (matricula),
    foreign key (FK_codigo) references rentacar.tipo_veiculo(codigo)
);
go

create table rentacar.aluger(
    numero int,
    duracao int not null,
    data date not null,
    FK_nif int not null,
    FK_matricula NVARCHAR(6) not null,
    FK_numero int not null,
    primary key (numero),
    foreign key (FK_nif) references rentacar.cliente(nif),
    foreign key (FK_matricula) references rentacar.veiculo(matricula),
    foreign key (FK_numero) references rentacar.balcao(numero)
);