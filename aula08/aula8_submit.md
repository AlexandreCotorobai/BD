# BD: Guião 8


## ​8.1. Complete a seguinte tabela.
Complete the following table.

| #    | Query                                                                                                      | Rows  | Cost   | Pag. Reads | Time (ms) | Index used | Index Op.            | Discussion |
| :--- | :--------------------------------------------------------------------------------------------------------- | :---- | :----- | :--------- | :-------- | :--------- | :------------------- | :--------- |
| 1    | SELECT * from Production.WorkOrder                                                                         | 72591 | 0.0800 | 1614       | 562       | 1          | Clustered Index Scan |            |
| 2    | SELECT * from Production.WorkOrder where WorkOrderID=1234                                                  | 1     | 0.0001 | 1094       | 113       | 1          | Clustered Index Seek |            |
| 3.1  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 10000 and 10010                               | 11    | 0.0001 | 1094       | 147       | 1          | Clustered Index Seek |            |
| 3.2  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 1 and 72591                                   | 72591 | 0.0800 | 1626       | 665       | 1          | Clustered Index Seek |            |
| 4    | SELECT * FROM Production.WorkOrder WHERE StartDate = '2012-05-14'                                          | 72591 | 0.0800 | 1622       | 139       | 1          | Clustered Index Scan |            |
| 5    | SELECT * FROM Production.WorkOrder WHERE ProductID = 757                                                   | 9     | 0.0001 | 806        | 134       | 1          | Index Seek           |            |
| 6.1  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 757                              | 9     | 0.0001 | 3044       | 41        | 2          | Index Seek           |            |
| 6.2  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945                              | 1105  | 0.0013 | 3107       | 136       | 2          | Index Seek           |            |
| 6.3  | SELECT WorkOrderID FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2011-12-04'            | 1105  | 0.0013 | 3111       | 35        | 2          | Index Seek           |            |
| 7    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2011-12-04' | 1     | 0.0001 | 4080       | 36        | 2          | Index Seek           |            |
| 8    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2011-12-04' | 1     | 0.0001 | 4080       | 43        | 2          | Index Seek           |            |

## ​8.2.

### a)

```
CREATE CLUSTERED INDEX RidKeyIndex ON mytemp(rid);
```

### b)

```
60650 Milisegundos
Percentagem de fragmentação dos índices = 99.08%
Ocupação das páginas dos índices = 67.51%
```

### c)

```
Fill Factor = 65% -> 53816 Milisegundos 
Fill Factor = 80% -> 65660 Milisegundos 
Fill Factor = 90% -> 58847 Milisegundos 

```

### d)

```
Fill Factor = 65% -> 59300 Milisegundos 
Fill Factor = 80% -> 75923 Milisegundos 
Fill Factor = 90% -> 62357 Milisegundos
```

### e)

```
Fill Factor = 65% -> 77747 Milisegundos 
Fill Factor = 80% -> 61157 Milisegundos 
Fill Factor = 90% -> 66670 Milisegundos

Assim concluimos que a inserção de registos no geral é mais lenta com índices. Isto pode acontecer porque ao criar mais índices são necessários mais recursos.

```

## ​8.3.

```
i.
    CREATE UNIQUE CLUSTERED INDEX PK_ssn ON Employee(Ssn)

ii.
    CREATE NONCLUSTERED INDEX IndexCompName ON Employee(Fname, Lname)

iii.
    CREATE UNIQUE CLUSTERED INDEX PK_Dnumber ON DEPARTMENT(Dnumber)
    CREATE NONCLUSTERED INDEX Index_Dno ON Employee(Dno)

iv.
    CREATE UNIQUE CLUSTERED INDEX PK_Ssn ON Employee(Ssn)
    CREATE UNIQUE CLUSTERED INDEX FK_Composite ON Works_on(Essn, Pno)
    CREATE UNIQUE NONCLUSTERED INDEX PK_Pnumber ON Project(Pnumber)  

v.          
    CREATE UNIQUE CLUSTERED INDEX PK_Ssn ON Employee(Ssn)
    CREATE UNIQUE CLUSTERED INDEX Index_Composite ON Dependent(Essn, Dependent_name)

vi.
    CREATE NONCLUSTERED INDEX Index_Dnum ON Project(Dnum)
    CREATE UNIQUE CLUSTERED INDEX Index_Dnumber ON Department(Dnumber)



```
