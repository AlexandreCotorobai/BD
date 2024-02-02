-- A

-- DROP PROCEDURE IF EXISTS dbo.RemoveEmployee;

-- CREATE PROCEDURE RemoveEmployee @Ssn INT
-- AS
--     BEGIN
        
--         DELETE FROM works_on WHERE Essn = @Ssn
--         DELETE From dependent WHERE Essn = @Ssn
--         UPDATE department SET Mgr_ssn = NULL WHERE Mgr_ssn = @Ssn
--         UPDATE employee SET Super_ssn = NULL WHERE Super_ssn = @Ssn
--         DELETE FROM employee WHERE Ssn = @Ssn
        
--     END;

-- GO

-- EXEC RemoveEmployee 12652121;
-- SELECT * FROM employee;



-- -- B

-- DROP PROCEDURE IF EXISTS dbo.GetMangers;
CREATE PROCEDURE GetMangers (@ossn INT output, @oyears DATE output)
AS
    BEGIN
    
        SELECT @ossn = Mgr_ssn, @oyears = DATEDIFF(YEAR, Mgr_start_date, GETDATE())
        FROM department WHERE Mgr_start_date IS NOT NULL ORDER BY Mgr_start_date DESC


        SELECT * FROM employee
        WHERE SSN IN (SELECT Mgr_ssn FROM department)
    END;

GO
DECLARE @ossn INT, @oyears DATE;
EXEC GetMangers @ossn output, @oyears output;
PRINT @ossn
PRINT @oyears;

-- -- C

--     CREATE TRIGGER ManagerSetTrigger 
--     ON Department
--     AFTER INSERT, UPDATE
--     AS
--         BEGIN
--             DECLARE @ManagerSsn INT
--             DECLARE @DepartmentNumber INT

--             SELECT @ManagerSsn = Mgr_ssn, @DepartmentNumber = Dnumber
--             FROM inserted

--             -- check if manager is already a manager
--             IF EXISTS (SELECT * FROM department WHERE Mgr_ssn = @ManagerSsn AND Dnumber <> @DepartmentNumber)
--                 BEGIN
--                     RAISERROR('Manager is already a manager of another department', 16, 1)
--                     ROLLBACK TRANSACTION
--                 END;
            
--         END;

--     GO;

-- -- D

-- CREATE TRIGGER EmployeeSalaryCheckTrigger
-- ON Employee
-- AFTER INSERT, UPDATE
-- AS
--     BEGIN
--         DECLARE @Salary DECIMAL(10,2)
--         DECLARE @Ssn INT
--         DECLARE @ManagerSsn INT
--         DECLARE @ManagerSalary DECIMAL(10,2)

--         SELECT @Salary = Salary, @Ssn = Ssn, @ManagerSsn = Mgr_ssn
--         FROM inserted

--         SELECT @ManagerSalary = Salary
--         FROM employee
--         WHERE Ssn = @ManagerSsn

--         IF @Salary > @ManagerSalary
--             BEGIN
--                 -- update salary to manager salary - 1
--                 UPDATE employee
--                 SET Salary = @ManagerSalary - 1
--                 WHERE Ssn = @Ssn
--             END;
--     END;

-- GO;

-- -- E

-- CREATE FUNCTION EmployeeInfo
-- (
--     @Ssn INT
-- )
-- RETURNS TABLE
-- AS
-- RETURN
--     SELECT PNAME, PLOCATION
--     FROM project
--     WHERE Pnumber IN (SELECT Pno FROM works_on WHERE Essn = @Ssn);

-- GO;

-- -- F

-- CREATE FUNCTION GetEmployeeGRavgSalary
-- (
--     @Dno INT
-- )
-- RETURNS TABLE
-- AS
-- RETURN
--     SELECT *
--     FROM Employee
--     WHERE salary > (SELECT AVG(Salary) FROM Employee WHERE Dno = @Dno);

-- GO;

-- -- G
