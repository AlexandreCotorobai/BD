
if exists (select * from sysdatabases where name='empresa')
begin
  raiserror('Dropping existing empresa database ....',0,1)
  DROP database empresa
end
GO

CHECKPOINT
go

raiserror('Creating empresa database....',0,1)
go
/*
   Use default size with autogrow
*/

CREATE DATABASE empresa
GO

USE empresa

GO




CREATE TABLE employee
(
    Fname VARCHAR(50) NOT NULL,
    Minit VARCHAR(50) NOT NULL,
    Lname VARCHAR(50) NOT NULL,
    Ssn INT NOT NULL,
    Bdate DATE NOT NULL,
    Address VARCHAR(50),
    Sex VARCHAR(50) NOT NULL,
    Salary FLOAT NOT NULL,
    Super_ssn INT,
    Dno INT,

    PRIMARY KEY (Ssn),
    FOREIGN KEY (Super_ssn) REFERENCES employee(Ssn),
)

GO

CREATE TABLE department
(
    Dname VARCHAR(50) NOT NULL,
    Dnumber INT NOT NULL,
    Mgr_ssn INT,
    Mgr_Start_Date DATE,

    PRIMARY KEY (Dnumber),
    FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn),
)

GO

ALTER TABLE employee ADD FOREIGN KEY (Dno) REFERENCES department(Dnumber)

Go

CREATE TABLE dependent 
(
    Essn INT NOT NULL,
    Dependent_name VARCHAR(50) NOT NULL,
    Sex VARCHAR(50) NOT NULL,
    Bdate DATE NOT NULL,
    Relationship VARCHAR(50) NOT NULL,

    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES employee(Ssn),
)

GO

CREATE TABLE dept_locations
(
    Dnumber INT NOT NULL,
    Dlocation VARCHAR(50) NOT NULL,

    PRIMARY KEY (Dnumber, Dlocation),
    FOREIGN KEY (Dnumber) REFERENCES department(Dnumber),
)

GO

CREATE TABLE project
(
    Pname VARCHAR(50) NOT NULL,
    Pnumber INT NOT NULL,
    Plocation VARCHAR(50) NOT NULL,
    Dnum INT NOT NULL,
    
    PRIMARY KEY (Pnumber),
    FOREIGN KEY (Dnum) REFERENCES department(Dnumber),
)

GO

CREATE TABLE works_on
(
    Essn INT NOT NULL,
    Pno INT NOT NULL,
    Hours FLOAT NOT NULL,

    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES employee(Ssn),
    FOREIGN KEY (Pno) REFERENCES project(Pnumber),
)

GO

INSERT INTO department
VALUES ('Investigacao',1,NULL,NULL),
('Comercial',2,NULL,NULL),
('Logistica',3,NULL,NULL),
('Recursos Humanos',4,NULL,NULL),
('Desporto',5,NULL,NULL);

GO

INSERT INTO employee 
VALUES ('Paula','A','Sousa',183623612,'2001-08-11','Rua da FRENTE','F',1450.00,NULL,3),
('Carlos','D','Gomes',21312332 ,'2000-01-01','Rua XPTO','M',1200.00,NULL,1),
('Juliana','A','Amaral',321233765,'1980-08-11','Rua BZZZZ','F',1350.00,NULL,3),
('Maria','I','Pereira',342343434,'2001-05-01','Rua JANOTA','F',1250.00,21312332,2),
('Joao','G','Costa',41124234 ,'2001-01-01','Rua YGZ','M',1300.00,21312332,2),
('Ana','L','Silva',12652121 ,'1990-03-03','Rua ZIG ZAG','F',1400.00,21312332,2);

GO

UPDATE department
SET Mgr_ssn = 21312332, Mgr_Start_Date = '2010-08-02'
WHERE Dnumber = 1;

UPDATE department
SET Mgr_ssn = 321233765, Mgr_Start_Date = '2013-05-16'
WHERE Dnumber = 2;

UPDATE department
SET Mgr_ssn = 41124234 , Mgr_Start_Date = '2013-05-16'
WHERE Dnumber = 3;

UPDATE department
SET Mgr_ssn = 12652121, Mgr_Start_Date = '2014-04-02'
WHERE Dnumber = 4;


INSERT INTO dependent 
VALUES (21312332 ,'Joana Costa','F','2008-04-01', 'Filho'),
(21312332 ,'Maria Costa','F','1990-10-05', 'Neto'),
(21312332 ,'Rui Costa','M','2000-08-04','Neto'),
(321233765,'Filho Lindo','M','2001-02-22','Filho'),
(342343434,'Rosa Lima','F','2006-03-11','Filho'),
(41124234 ,'Ana Sousa','F','2007-04-13','Neto'),
(41124234 ,'Gaspar Pinto','M','2006-02-08','Sobrinho');

GO

INSERT INTO dept_locations 
VALUES (2,'Aveiro'),
(3,'Coimbra');

GO

INSERT INTO project 
VALUES ('Aveiro Digital',1,'Aveiro',3),
('BD Open Day',2,'Espinho',2),
('Dicoogle',3,'Aveiro',3),
('GOPACS',4,'Aveiro',3);

GO

INSERT INTO works_on 
VALUES (183623612,1,20.0),
(183623612,3,10.0),
(21312332 ,1,20.0),
(321233765,1,25.0),
(342343434,1,20.0),
(342343434,4,25.0),
(41124234 ,2,20.0),
(41124234 ,3,30.0);

GO


