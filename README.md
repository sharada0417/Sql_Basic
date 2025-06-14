-- SQL Basic Ex - 1

-- Create Department table
CREATE TABLE Department (
    DeptId INT PRIMARY KEY,
    DName VARCHAR(255),
    Location VARCHAR(255)
);

-- Create Employee table
CREATE TABLE Employee (
    EmpId INT PRIMARY KEY,
    EmpName VARCHAR(255),
    Job VARCHAR(255),
    DeptId INT,
    DOB DATE,
    FOREIGN KEY (DeptId) REFERENCES Department(DeptId)
);

-- Insert records into Department
INSERT INTO Department (DeptId, DName, Location)
VALUES
(1732,'Production','Jaffna'),
(1654,'Supply','Vavuniya'),
(1543,'Planning','Colombo'),
(2312,'Mechanical','Kilinochchi'),
(2323,'Finance','Mankulam');

-- Insert records into Employee
INSERT INTO Employee (EmpId, EmpName, Job, DeptId, DOB)
VALUES
(111, 'Finch', 'Clerk', 1543, '1993-02-04'),
(112, 'Warner', 'Engineer', 2312, '1994-03-17'),
(113, 'Smith', 'Manager', 1732, '1989-05-13'),
(114, 'Maxwel', 'Engineer', 2323, '1990-08-27'),
(115, 'Stare', 'Clerk', 1732, '1979-08-31'),
(116, 'Cummins', 'Technician', 2312, '1998-09-11'),
(117, 'Zampa', 'Technician', 1654, '1997-12-09'),
(118, 'Carrery', 'Manager', 1654, '1996-04-29');

-- Add Salary column
ALTER TABLE Employee ADD COLUMN Salary INT(5) AFTER Job;

-- Update Salary data
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

-- Sample Queries and Outputs

-- 1. Employees whose name starts with 'S'
SELECT EmpName FROM Employee WHERE EmpName LIKE 'S%';
-- Output:
-- +---------+
-- | EmpName |
-- +---------+
-- | Smith   |
-- | Stare   |
-- +---------+

-- 2. Count Managers
SELECT COUNT(*) AS ManagerCounter FROM Employee WHERE Job = 'Manager';
-- Output:
-- +----------------+
-- | ManagerCounter |
-- +----------------+
-- |              2 |
-- +----------------+

-- 3. Employees with salary greater than 30000
SELECT EmpId, Job FROM Employee WHERE Salary > 30000;
-- Output:
-- +-------+------------+
-- | EmpId | Job        |
-- +-------+------------+
-- |   112 | Engineer   |
-- |   113 | Manager    |
-- |   114 | Engineer   |
-- |   116 | Technician |
-- |   117 | Technician |
-- |   118 | Manager    |
-- +-------+------------+

-- 4. Department names in Jaffna
SELECT Department.DName
FROM Department
JOIN Employee ON Department.DeptId = Employee.DeptId
WHERE Department.Location = 'Jaffna';
-- Output:
-- +------------+
-- | DName      |
-- +------------+
-- | Production |
-- | Production |
-- +------------+

-- 5. Employees who work as Technicians
SELECT employee.EmpId, employee.EmpName, employee.DeptId, department.DName
FROM employee
JOIN department ON employee.DeptId = department.DeptId
WHERE employee.Job = 'Technician';
-- Output:
-- +-------+---------+--------+------------+
-- | EmpId | EmpName | DeptId | DName      |
-- +-------+---------+--------+------------+
-- |   116 | Cummins |   2312 | Mechanical |
-- |   117 | Zampa   |   1654 | Supply     |
-- +-------+---------+--------+------------+

-- 6. Departments where max salary > 50000
SELECT Department.DName
FROM Department
JOIN Employee ON Department.DeptId = Employee.DeptId
GROUP BY department.DName
HAVING MAX(Salary) > 50000;
-- Output:
-- +------------+
-- | DName      |
-- +------------+
-- | Finance    |
-- | Mechanical |
-- | Production |
-- | Supply     |
-- +------------+

-- 7. Average salary per department in descending order
SELECT department.DName, AVG(employee.Salary) AS AvgSalary
FROM employee
JOIN department ON employee.DeptId = department.DeptId
GROUP BY department.DName
ORDER BY AvgSalary DESC;
-- Output:
-- +------------+------------+
-- | DName      | AvgSalary  |
-- +------------+------------+
-- | Finance    | 65000.0000 |
-- | Mechanical | 55000.0000 |
-- | Production | 44000.0000 |
-- | Supply     | 43500.0000 |
-- | Planning   | 25000.0000 |
-- +------------+------------+
