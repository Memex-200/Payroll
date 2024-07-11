--USE Payroll;

-- Create the Employee table first
CREATE TABLE Employees (
    Employee_Id INT,
    First_Name VARCHAR(25),
    Last_Name VARCHAR(25),
    Hire_Date DATE,
    City VARCHAR(25),
    State VARCHAR(25),
    CONSTRAINT EMPLOYEE_PK PRIMARY KEY (Employee_Id)
);

-- Create the Department table
CREATE TABLE Department(
    Department_Id INT,
    Department_Name VARCHAR(30),
    CONSTRAINT DEPARTMENT_PK PRIMARY KEY (Department_Id)
);

-- Create the Project table
CREATE TABLE Project(
    Project_Id INT,
    Project_Name VARCHAR(50),
    Project_Description VARCHAR(50),
    CONSTRAINT Project_PK PRIMARY KEY (Project_Id)
);

-- Create the AccountDetails table
CREATE TABLE AccountDetails(
    Account_Id INT,
    Bank_Name VARCHAR(50),
    Account_Number VARCHAR(50),
    Employee_Id INT,
    CONSTRAINT Account_PK PRIMARY KEY (Account_Id),
    FOREIGN KEY (Employee_Id) REFERENCES Employees(Employee_Id)
);

-- Create the Salary table
CREATE TABLE Salary (
    Salary_Id INT,
    Gross_Salary INT,
    Hourly_Pay INT,
    Account_Id INT,
    CONSTRAINT SALARY_PK PRIMARY KEY (Salary_Id),
    FOREIGN KEY (Account_Id) REFERENCES AccountDetails(Account_Id)
);

-- Create the DepartmentProject table
CREATE TABLE DepartmentProject(
    Department_Id INT,
    Project_Id INT,
    CONSTRAINT DEPTPROJECT_PK PRIMARY KEY (Department_Id, Project_Id),
    FOREIGN KEY (Department_Id) REFERENCES Department(Department_Id),
    FOREIGN KEY (Project_Id) REFERENCES Project(Project_Id)
);

-- Create the Education table
CREATE TABLE Education(
    Education_Id INT,
    Employee_Id INT,
    Degree VARCHAR(30),
    Graduation_Year INT,
    CONSTRAINT Location_PK PRIMARY KEY (Education_Id),
    FOREIGN KEY (Employee_Id) REFERENCES Employees(Employee_Id)
);

-- Create the Leave table
CREATE TABLE Leave(
    Leave_Id INT,
    Employee_Id INT,
    Leave_date DATE,
    CONSTRAINT Leave_PK PRIMARY KEY (Leave_Id),
    FOREIGN KEY (Employee_Id) REFERENCES Employees(Employee_Id)
);

-- Create the Attendance table
CREATE TABLE Attendance(
    Attendance_Id INT,
    Hours_Worked INT,
    CONSTRAINT Attendance_PK PRIMARY KEY (Attendance_Id)
);

-- Create the Employee_Attendance table
CREATE TABLE Employee_Attendance(
    Employee_Id INT,
    Attendance_Id INT,
    CONSTRAINT DEPARTMENTPROJECT_PK PRIMARY KEY (Employee_Id, Attendance_Id),
    FOREIGN KEY (Employee_Id) REFERENCES Employees(Employee_Id),
    FOREIGN KEY (Attendance_Id) REFERENCES Attendance(Attendance_Id)
);

-- Create the Work_Location table
CREATE TABLE Work_Location(
    Location_Id INT,
    Location VARCHAR(25),
    Number_Of_Employees INT,
    City VARCHAR(25),
    State VARCHAR(25),
    CONSTRAINT Loc_PK PRIMARY KEY (Location_Id)
);

-- Insert values into Employees table
INSERT INTO Employees (Employee_Id, First_Name, Last_Name, Hire_Date, City, State)
VALUES
(1, 'John', 'Doe', '2022-01-15', 'New York', 'NY'),
(2, 'Jane', 'Smith', '2023-03-22', 'Los Angeles', 'CA');

-- Insert values into Department table
INSERT INTO Department (Department_Id, Department_Name)
VALUES
(1, 'Engineering'),
(2, 'Human Resources');

-- Insert values into Project table
INSERT INTO Project (Project_Id, Project_Name, Project_Description)
VALUES
(1, 'Apollo', 'A new web application'),
(2, 'Zeus', 'A cloud infrastructure project');

-- Insert values into AccountDetails table
INSERT INTO AccountDetails (Account_Id, Bank_Name, Account_Number, Employee_Id)
VALUES
(1, 'Bank of America', '1234567890', 1),
(2, 'Wells Fargo', '9876543210', 2);

-- Insert values into Salary table
INSERT INTO Salary (Salary_Id, Gross_Salary, Hourly_Pay, Account_Id)
VALUES
(1, 80000, 40, 1),
(2, 90000, 45, 2);

-- Insert values into DepartmentProject table
INSERT INTO DepartmentProject (Department_Id, Project_Id)
VALUES
(1, 1),
(2, 2);

-- Insert values into Education table
INSERT INTO Education (Education_Id, Employee_Id, Degree, Graduation_Year)
VALUES
(1, 1, 'Bachelor of Science', 2020),
(2, 2, 'Master of Arts', 2021);

-- Insert values into Leave table
INSERT INTO Leave (Leave_Id, Employee_Id, Leave_date)
VALUES
(1, 1, '2023-07-01'),
(2, 2, '2023-08-01');

-- Insert values into Attendance table
INSERT INTO Attendance (Attendance_Id, Hours_Worked)
VALUES
(1, 160),
(2, 150);

-- Insert values into Employee_Attendance table
INSERT INTO Employee_Attendance (Employee_Id, Attendance_Id)
VALUES
(1, 1),
(2, 2);

-- Insert values into Work_Location table
INSERT INTO Work_Location (Location_Id, Location, Number_Of_Employees, City, State)
VALUES
(1, 'Headquarters', 100, 'New York', 'NY'),
(2, 'West Coast Office', 50, 'Los Angeles', 'CA');



--Retrieve all employees and their departments
SELECT e.Employee_Id, e.First_Name, e.Last_Name, d.Department_Name
FROM Employees e
JOIN DepartmentProject dp ON e.Employee_Id = dp.Department_Id
JOIN Department d ON dp.Department_Id = d.Department_Id;

--Retrieve all employees working on a specific project
SELECT e.Employee_Id, e.First_Name, e.Last_Name, p.Project_Name
FROM Employees e
JOIN DepartmentProject dp ON e.Employee_Id = dp.Department_Id
JOIN Project p ON dp.Project_Id = p.Project_Id
WHERE p.Project_Name = 'Apollo';

--Update an employee's information
UPDATE Employees
SET First_Name = 'Jonathan', Last_Name = 'Doe'
WHERE Employee_Id = 1;

--Delete an employee's record
DELETE FROM Employees
WHERE Employee_Id = 2;

--Retrieve salary details of employees
SELECT e.Employee_Id, e.First_Name, e.Last_Name, s.Gross_Salary, s.Hourly_Pay
FROM Employees e
JOIN AccountDetails ad ON e.Employee_Id = ad.Employee_Id
JOIN Salary s ON ad.Account_Id = s.Account_Id;

--Add a new employee
INSERT INTO Employees (Employee_Id, First_Name, Last_Name, Hire_Date, City, State)
VALUES (3, 'Alice', 'Johnson', '2024-01-01', 'San Francisco', 'CA');

--Assign an employee to a project
INSERT INTO DepartmentProject (Department_Id, Project_Id)
VALUES (1, 2);

--Grant leave to an employee
INSERT INTO Leave (Leave_Id, Employee_Id, Leave_date)
VALUES (3, 3, '2024-07-15');

--Record attendance for an employee
INSERT INTO Attendance (Attendance_Id, Hours_Worked)
VALUES (3, 170);

INSERT INTO Employee_Attendance (Employee_Id, Attendance_Id)
VALUES (3, 3);

-- Retrieve all data from Employees table
SELECT * FROM Employees;

-- Retrieve all data from Department table
SELECT * FROM Department;

-- Retrieve all data from Project table
SELECT * FROM Project;

-- Retrieve all data from AccountDetails table
SELECT * FROM AccountDetails;

-- Retrieve all data from Salary table
SELECT * FROM Salary;

-- Retrieve all data from DepartmentProject table
SELECT * FROM DepartmentProject;

-- Retrieve all data from Education table
SELECT * FROM Education;

-- Retrieve all data from Leave table
SELECT * FROM Leave;

-- Retrieve all data from Attendance table
SELECT * FROM Attendance;

-- Retrieve all data from Employee_Attendance table
SELECT * FROM Employee_Attendance;

-- Retrieve all data from Work_Location table
SELECT * FROM Work_Location;


