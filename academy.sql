USE master;
GO

IF DB_ID('Academy') IS NOT NULL
BEGIN
    ALTER DATABASE Academy SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Academy;
END
GO

CREATE DATABASE Academy;
GO

USE Academy;
GO

CREATE TABLE Groups (
    Id int IDENTITY(1,1) NOT NULL,
    Name nvarchar(10) NOT NULL,
    Rating int NOT NULL,
    [Year] int NOT NULL,

    CONSTRAINT PK_Groups PRIMARY KEY (Id),
    CONSTRAINT UQ_Groups_Name UNIQUE (Name),
    CONSTRAINT CK_Groups_Name_NotEmpty CHECK (Name <> ''),
    CONSTRAINT CK_Groups_Rating CHECK (Rating BETWEEN 0 AND 5),
    CONSTRAINT CK_Groups_Year CHECK ([Year] BETWEEN 1 AND 5)
);
GO

CREATE TABLE Departments (
    Id int IDENTITY(1,1) NOT NULL,
    Financing money NOT NULL CONSTRAINT DF_Departments_Financing DEFAULT 0,
    Name nvarchar(100) NOT NULL,

    CONSTRAINT PK_Departments PRIMARY KEY (Id),
    CONSTRAINT UQ_Departments_Name UNIQUE (Name),
    CONSTRAINT CK_Departments_Name_NotEmpty CHECK (Name <> ''),
    CONSTRAINT CK_Departments_Financing CHECK (Financing >= 0)
);
GO

CREATE TABLE Faculties (
    Id int IDENTITY(1,1) NOT NULL,
    Name nvarchar(100) NOT NULL,

    CONSTRAINT PK_Faculties PRIMARY KEY (Id),
    CONSTRAINT UQ_Faculties_Name UNIQUE (Name),
    CONSTRAINT CK_Faculties_Name_NotEmpty CHECK (Name <> '')
);
GO

CREATE TABLE Teachers (
    Id int IDENTITY(1,1) NOT NULL,
    EmploymentDate date NOT NULL,
    Name nvarchar(max) NOT NULL,
    Premium money NOT NULL CONSTRAINT DF_Teachers_Premium DEFAULT 0,
    Salary money NOT NULL,
    Surname nvarchar(max) NOT NULL,

    CONSTRAINT PK_Teachers PRIMARY KEY (Id),
    CONSTRAINT CK_Teachers_EmploymentDate CHECK (EmploymentDate >= '1990-01-01'),
    CONSTRAINT CK_Teachers_Name_NotEmpty CHECK (Name <> ''),
    CONSTRAINT CK_Teachers_Surname_NotEmpty CHECK (Surname <> ''),
    CONSTRAINT CK_Teachers_Premium CHECK (Premium >= 0),
    CONSTRAINT CK_Teachers_Salary CHECK (Salary > 0)
);
GO

INSERT INTO Faculties (Name) VALUES 
('Комп''ютерних наук'),
('Кібербезпеки та ПЗ'),
('Дизайну та медіа');
GO

INSERT INTO Departments (Name, Financing) VALUES 
('Кафедра програмної інженерії', 125000.00),
('Кафедра штучного інтелекту', 180000.00),
('Кафедра мережевих технологій', 95000.00);
GO

INSERT INTO Groups (Name, Rating, [Year]) VALUES 
('КН-101', 4, 1),
('ПІ-202', 5, 2),
('КБ-303', 3, 3);
GO

INSERT INTO Teachers (EmploymentDate, Name, Surname, Salary, Premium) VALUES 
('2015-09-01', 'Олександр', 'Мельник', 25000.00, 5000.00),
('2018-02-15', 'Тетяна', 'Коваленко', 22000.00, 3500.00),
('2020-10-01', 'Ігор', 'Шевченко', 19500.00, 0.00);
GO

SELECT * FROM Faculties;
SELECT * FROM Departments;
SELECT * FROM Groups;
SELECT * FROM Teachers;
GO
