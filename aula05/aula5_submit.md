## ​Problema 5.1
 
### *a)*

```
π Pname, Pnumber, Ssn, Fname, Minit, Lname ((project ⨝Pnumber=Pno works_on)⨝Essn=Ssn employee)
```


### *b)* 

```
π Fname, Minit, Lname, Ssn, SupFname, SupMinit, SupLname, SupSsn (employee ⨝ Super_ssn=SupSsn (ρ SupSsn←Ssn, SupFname←Fname, SupMinit←Minit, SupLname←Lname π Ssn, Fname, Minit, Lname σ Fname='Carlos' ∧ Minit='D' ∧ Lname='Gomes' employee))
```


### *c)* 

```
π Pname, FullHours (project ⨝Pnumber=Pno (γ Pno; sum(Hours)->FullHours works_on))
```


### *d)* 

```
π Fname, Minit, Lname, Dno, Hours (σ Dno = 3 (employee ⨝Ssn=Essn (σ Hours > 20 (works_on ⨝Pno=Pnumber σ Pname = 'Aveiro Digital' project))))
```


### *e)* 

```
π Fname, Minit, Lname (σ Essn=null (employee ⟕ Ssn=Essn works_on))
```


### *f)* 

```
π Dname, AvgSal ((department) ⨝Dnumber=Dno γ Dno; avg(Salary)->AvgSal (σ Sex='F' (employee)))
```


### *g)* 

```
employee ⨝Ssn=Essn (σ DepNo>2 (γ Essn; count(Essn)->DepNo dependent))
```


### *h)* 

```
π Fname, Minit, Lname (σ dependent.Dependent_name=null ((employee ⨝ Ssn=Mgr_ssn π Dname,Mgr_ssn (department)) ⟕ Ssn=Essn dependent))
```


### *i)* 

```
π Fname, Minit, Lname,Address (σ Dlocation≠'Aveiro' (dept_location)⨝(Dnumber=Dno) (σ Plocation='Aveiro' ( project ⨝ Pnumber=Pno (employee ⨝ (Ssn=Essn) works_on))))
```


## ​Problema 5.2

### *a)*

```
π fornecedor.nif, fornecedor.nome (σ encomenda.numero=null (π nif,nome fornecedor⟕ (nif=fornecedor) π numero,fornecedor encomenda))
```

### *b)* 

```
γ codProd; avg(unidades)->TotalUnidades item
```


### *c)* 

```
X = γ numEnc; count(codProd) -> totalProdutos item

γ avg(totalProdutos) -> AvgProd X
```


### *d)* 

```
x = (π codigo,nome,unidades produto ⟕ codigo=codProd item) ⟕ numEnc=numero encomenda ⟕ encomenda.fornecedor=nif fornecedor

γ produto.nome,fornecedor.nome; sum(item.unidades)->TotalUnidades (x)
```


## ​Problema 5.3

### *a)*

```
σ numPresc=null (paciente ⟕ prescricao)
```

### *b)* 

```
γ especialidade; count(especialidade)->numReceitas (medico ⨝numSNS=numMedico prescricao)
```
### *c)* 

```
σ farmacia!=null (γ farmacia; count(farmacia)->NoPrescricao (prescricao))
```


### *d)* 

```
σ numPresc=null ((σ numRegFarm=906 (farmaco)) ⟕nome=nomeFarmaco (σ numRegFarm=906 (presc_farmaco)))
```

### *e)* 

```
σ farmacia!=null (γ farmacia, numRegFarm; count(numPresc)->NoSales (prescricao ⨝ presc_farmaco))
```

### *f)* 

```
paciente ⨝ σ NoUniqueMedics > 1 (γ numUtente; count(numUtente)->NoUniqueMedics (γ numUtente, numMedico; count(numMedico)->NoMedics prescricao))
```