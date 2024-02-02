USE empresa
-- a) 
--π Pname, Pnumber, Ssn, Fname, Lname ((project ⨝Pnumber=Pno works_on)⨝Essn=Ssn employee)

-- SELECT project.Pname, project.Pnumber, employee.Ssn, employee.Fname, employee.Lname
-- FROM project
-- INNER JOIN works_on ON project.Pnumber = works_on.Pno
-- INNER JOIN employee ON works_on.Essn = employee.Ssn


-- b)
-- SELECT *
-- FROM employee S1, (SELECT Ssn AS SupSsn, Fname AS SupFname,
-- Minit AS SupMinit, Lname AS SupLname FROM employee 
-- WHERE Fname = 'Carlos' AND Minit = 'D' AND Lname = 'Gomes') S2
-- WHERE S1.Super_ssn = S2.SupSsn


-- c)
-- π Pname, FullHours (project ⨝Pnumber=Pno (γ Pno; sum(Hours)->FullHours works_on))

-- SELECT project.Pname, SUM(works_on.Hours) AS FullHours
-- FROM project
-- INNER JOIN works_on ON project.Pnumber = works_on.Pno
-- GROUP BY project.Pname


-- d)
-- π Fname, Minit, Lname, Dno, Hours (σ Dno = 3 (employee ⨝Ssn=Essn (σ Hours > 20 (works_on ⨝Pno=Pnumber σ Pname = 'Aveiro Digital' project))))

-- SELECT employee.Fname, employee.Minit, employee.Lname, employee.Dno, works_on.Hours
-- FROM employee
-- INNER JOIN works_on ON employee.Ssn = works_on.Essn
-- INNER JOIN project ON works_on.Pno = project.Pnumber
-- WHERE employee.Dno = 3 AND works_on.Hours > 20 AND project.Pname = 'Aveiro Digital'


-- e)
-- π Fname,Lname (σ Essn=null (employee ⟕ Ssn=Essn works_on))

-- SELECT employee.Fname, employee.Lname
-- FROM employee
-- LEFT JOIN works_on ON employee.Ssn = works_on.Essn
-- WHERE works_on.Essn IS NULL


-- f)
-- π Dname, AvgSal ((department) ⨝Dnumber=Dno γ Dno; avg(Salary)->AvgSal (σ Sex='F' (employee)))

-- SELECT department.Dname, AVG(employee.Salary) AS AvgSal
-- FROM department
-- JOIN employee ON department.Dnumber = employee.Dno
-- WHERE employee.Sex = 'F'
-- GROUP BY employee.Dno, department.Dname


-- g)
-- employee ⨝Ssn=Essn (σ DepNo>2 (γ Essn; count(Essn)->DepNo dependent))

-- SELECT employee.Fname, employee.Lname, employee.Ssn, COUNT(dependent.Essn) AS DepNo
-- FROM employee
-- JOIN dependent ON employee.Ssn = dependent.Essn
-- GROUP BY employee.Fname, employee.Lname, employee.Ssn
-- HAVING COUNT(dependent.Essn) > 2


-- h)
-- π Fname, Minit, Lname (σ dependent.Dependent_name=null ((employee ⨝ Ssn=Mgr_ssn π Dname,Mgr_ssn (department)) ⟕ Ssn=Essn dependent))

-- SELECT employee.Fname, employee.Minit, employee.Lname
-- FROM employee
-- JOIN department ON employee.Ssn = department.Mgr_ssn
-- LEFT JOIN dependent ON employee.Ssn = dependent.Essn
-- WHERE dependent.Dependent_name IS NULL

-- i)
-- π Fname, Minit, Lname,Address (σ Dlocation≠'Aveiro' (dept_location)⨝(Dnumber=Dno) (σ Plocation='Aveiro' ( project ⨝ Pnumber=Pno (employee ⨝ (Ssn=Essn) works_on))))

-- SELECT DISTINCT newtable2.Fname, newtable2.Minit, newtable2.Lname, newtable2.Address
-- FROM dept_locations
-- JOIN (
--     SELECT *
--     FROM project
--     JOIN (
--         SELECT *
--         FROM employee
--         JOIN works_on ON employee.Ssn = works_on.Essn
        
--     ) AS newtable ON project.Pnumber = newtable.Pno
--     WHERE project.Plocation = 'Aveiro'
    
-- ) AS newtable2 ON dept_locations.Dnumber = newtable2.Dno
-- WHERE dept_locations.Dlocation <> 'Aveiro'
