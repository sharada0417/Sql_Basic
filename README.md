                                                                            # Tutorial - 01
# SQL Basic Ex - 1

This SQL exercise demonstrates the creation of tables, insertion of data, foreign key usage, and various SELECT queries using aggregate functions and joins in a sample `Company` database.

## Table Creation

```sql
CREATE TABLE Department (
    DeptId INT PRIMARY KEY,
    DName VARCHAR(255),
    Location VARCHAR(255)
);

CREATE TABLE Employee (
    EmpId INT PRIMARY KEY,
    EmpName VARCHAR(255),
    Job VARCHAR(255),
    DeptId INT,
    DOB DATE,
    FOREIGN KEY (DeptId) REFERENCES Department(DeptId)
);
```

## Data Insertion

```sql
INSERT INTO Department (DeptId, DName, Location) VALUES
(1732,'Production','Jaffna'),
(1654,'Supply','Vavuniya'),
(1543,'Planning','Colombo'),
(2312,'Mechanical','Kilinochchi'),
(2323,'Finance','Mankulam');

INSERT INTO Employee (EmpId, EmpName, Job, DeptId, DOB) VALUES
(111, 'Finch', 'Clerk', 1543, '1993-02-04'),
(112, 'Warner', 'Engineer', 2312, '1994-03-17'),
(113, 'Smith', 'Manager', 1732, '1989-05-13'),
(114, 'Maxwel', 'Engineer', 2323, '1990-08-27'),
(115, 'Stare', 'Clerk', 1732, '1979-08-31'),
(116, 'Cummins', 'Technician', 2312, '1998-09-11'),
(117, 'Zampa', 'Technician', 1654, '1997-12-09'),
(118, 'Carrery', 'Manager', 1654, '1996-04-29');
```

## Add Salary and Update Values

```sql
ALTER TABLE Employee ADD COLUMN Salary INT(5) AFTER Job;

UPDATE Employee SET Salary = CASE EmpId
  WHEN 111 THEN 25000
  WHEN 112 THEN 75000
  WHEN 113 THEN 60000
  WHEN 114 THEN 65000
  WHEN 115 THEN 28000
  WHEN 116 THEN 35000
  WHEN 117 THEN 32000
  WHEN 118 THEN 55000
END;
```

## Queries and Outputs

### 1. Employees whose names start with 'S'

```sql
SELECT EmpName FROM Employee WHERE EmpName LIKE 'S%';
```

| EmpName |
|---------|
| Smith   |
| Stare   |

### 2. Count of Managers

```sql
SELECT COUNT(*) AS ManagerCounter FROM Employee WHERE Job = 'Manager';
```

| ManagerCounter |
|----------------|
| 2              |

### 3. Employees with salary > 30000

```sql
SELECT EmpId, Job FROM Employee WHERE Salary > 30000;
```

| EmpId | Job        |
|-------|------------|
| 112   | Engineer   |
| 113   | Manager    |
| 114   | Engineer   |
| 116   | Technician |
| 117   | Technician |
| 118   | Manager    |

### 4. Departments located in Jaffna

```sql
SELECT Department.DName
FROM Department
JOIN Employee ON Department.DeptId = Employee.DeptId
WHERE Department.Location = 'Jaffna';
```

| DName      |
|------------|
| Production |
| Production |

### 5. Employees who work as Technicians

```sql
SELECT employee.EmpId, employee.EmpName, employee.DeptId, department.DName
FROM employee
JOIN department ON employee.DeptId = department.DeptId
WHERE employee.Job = 'Technician';
```

| EmpId | EmpName | DeptId | DName      |
|-------|---------|--------|------------|
| 116   | Cummins | 2312   | Mechanical |
| 117   | Zampa   | 1654   | Supply     |

### 6. Departments with max salary > 50000

```sql
SELECT Department.DName
FROM Department
JOIN Employee ON Department.DeptId = Employee.DeptId
GROUP BY department.DName
HAVING MAX(Salary) > 50000;
```

| DName      |
|------------|
| Finance    |
| Mechanical |
| Production |
| Supply     |

### 7. Average salary per department (Descending)

```sql
SELECT department.DName, AVG(employee.Salary) AS AvgSalary
FROM employee
JOIN department ON employee.DeptId = department.DeptId
GROUP BY department.DName
ORDER BY AvgSalary DESC;
```

| DName      | AvgSalary  |
|------------|------------|
| Finance    | 65000.0000 |
| Mechanical | 55000.0000 |
| Production | 44000.0000 |
| Supply     | 43500.0000 |
| Planning   | 25000.0000 |
