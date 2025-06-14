create database Company;

use Company;

create table Department(
	DeptId int,
	Dname varchar(255),
	Location varchar(255),
	PRIMARY Key(DeptId)
);

create table Employee(
	EmpId int,
	EmpName varchar(255),
	Job varchar(255),
	DeptId int,
	DOB DATE,
	PRIMARY KEY(EmpId)
);

Insert into Department
(DeptId,DName,Location)
VALUES
(1732,'Production','Jaffna'), 
(1654,'Supply','Vavuniya'),
(1543,'Planning','Colombo'),
(2312,'Mechanical','Kilinochchi'), 
(2323,'Finance','Mankulam');


INSERT INTO Employee (EmpId, EmpName, Job, DeptId, DOB)
VALUES
(111, 'Finch', 'Clerk', 1543, '1993-02-04'),
(112, 'Warner', 'Engineer', 2312, '1994-03-17'),
(113, 'Smith', 'Manager', 1732, '1989-05-13'),
(114, 'Maxwel', 'Accountant', 2323, '1990-08-27'),
(115, 'Stare', 'Clerk', 1732, '1979-08-31'),
(116, 'Cummins', 'Technician', 2312, '1998-09-11'),
(117, 'Zampa', 'Technician', 1654, '1997-12-09'),
(118, 'Carrery', 'Manager', 1654, '1996-04-29');



ALTER TABLE Employee
ADD FOREIGN KEY (DeptId)
REFERENCES Department(DeptId);

DESC Department;
DESC Employee;

select * from Employee;
select * from Department;

SELECT EmpName
FROM Employee
WHERE EmpName LIKE "s%";


SELECT COUNT(*) AS MangeCounter
FROM Employee
WHERE Job = 'Manager';


ALTER TABLE Employee
ADD column Salary INT(5)
AFTER Job;
UPDATE Employee SET Salary = 
CASE EmpId
	WHEN 111 THEN 25000
    WHEN 112 THEN 75000
    WHEN 113 THEN 60000
    WHEN 114 THEN 65000
    WHEN 115 THEN 28000
    WHEN 116 THEN 35000
    WHEN 117 THEN 32000
    WHEN 118 THEN 55000
 END;
 
 SELECT * FROM Employee;
 
SELECT EmpId , Job
FROM Employee
Where Salary > 30000;


SELECT Department.Dname
FROM Department
JOIN Employee ON Department.DeptId = Employee.DeptId
WHERE Department.Location = 'Jaffna';

UPDATE Employee
SET Job = 'Engineer'
WHERE EmpId = 114;

SELECT *
FROM Employee;

SELECT *
FROM Employee
WHERE DeptId LIKE '___2';

SELECT Department.DName
FROM Department
JOIN Employee ON Department.DeptId = Employee.DeptId
GROUP By department.DName 
HAVING MAX(Salary) > 50000;

SELECT department.DName, AVG(employee.Salary) AS AvgSalary
FROM employee
JOIN department ON employee.DeptId = department.DeptId
GROUP BY department.DName
ORDER BY AvgSalary DESC;



SELECT employee.EmpId, employee.EmpName, employee.DeptId, department.DName
FROM employee
JOIN department ON employee.DeptId = department.DeptId
WHERE employee.Job = 'Technician';

