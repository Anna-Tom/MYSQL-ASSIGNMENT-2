USE EMPLOYEE;
--   a query to retrieve distinct salaries from the Employees table
SELECT DISTINCT SALARY FROM EMPLOYEES;

-- Provide aliases for the "age" and "salary" columns as "Employee_Age" and "Employee_Salary", respectively.
SELECT AGE AS EMPLOYEE_AGE FROM EMPLOYEES;
SELECT  SALARY AS EMPLOYEE_SALARY FROM EMPLOYEES;

--   Retrieve employees with a salary greater than ₹50000 and hired before 2016-01-01. 
SELECT * FROM EMPLOYEES WHERE SALARY > 50000 AND HIRE_DATE < '2016-01-01';

--   Find the employee whose designation is missing and fill it with "Data Scientist". 
SET SQL_SAFE_UPDATES=0;
UPDATE EMPLOYEES
SET DESIGNATION = 'Data Scientist' WHERE DESIGNATION IS NULL;

--   Find employees sorted by department ID in ascending order and salary in descending order. 
SELECT  EMPLOYEE_NAME, DEPARTMENT_ID, SALARY FROM EMPLOYEES ORDER BY DEPARTMENT_ID ASC, SALARY DESC;

-- Display the first 5 employees hired in the year 2018. 
SELECT * FROM EMPLOYEES WHERE YEAR(HIRE_DATE)=2018 ORDER BY HIRE_DATE LIMIT 5;

-- Calculate the sum of all salaries in the Finance department.
SELECT SUM(salary) AS total_finance_salary
FROM employees
WHERE department_id = (
    SELECT department_id 
    FROM departments 
    WHERE department_name = 'Finance'
);
--   Find the minimum age among all employees. 
SELECT MIN(AGE) FROM EMPLOYEES;

--  List the maximum salary for each location. 
SELECT l.location, salary_data.max_salary
FROM location l,
     (
         SELECT location_id, MAX(salary) AS max_salary 
         FROM employees 
         GROUP BY location_id
     ) salary_data
WHERE l.location_id = salary_data.location_id;

--  Calculate the average salary for each designation containing the word 'Analyst'. 
SELECT DESIGNATION , AVG(SALARY) FROM EMPLOYEES WHERE DESIGNATION LIKE '%ANALYST%' GROUP BY DESIGNATION;

--  Find departments with less than 3 employees. 
SELECT d.department_name, COUNT(e.employee_id) AS total_employees
FROM departments d, employees e
WHERE d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) < 3;

-- Find locations with female employees whose average age is below 30.
SELECT l.location, AVG(e.age) AS average_age
FROM location l, employees e
WHERE l.location_id = e.location_id
  AND e.gender = 'Female'
GROUP BY l.location
HAVING AVG(e.age) < 30;

--  List employee names, their designations, and department names where employees are assigned to a department.
SELECT E.EMPLOYEE_NAME, E.DESIGNATION, D.DEPARTMENT_NAME FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID=D.DEPARTMENT_ID;

--   List all departments along with the total number of employees in each department, including departments with no employees.
SELECT D.DEPARTMENT_NAME, COUNT(E.DEPARTMENT_ID) AS TOTAL_EMPLOYEES FROM DEPARTMENTS D
LEFT JOIN EMPLOYEES E ON D.DEPARTMENT_ID=E.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME;

-- Display all locations along with the names of employees assigned to each location. If no employees are assigned to a location, display NULL for employee name.
SELECT  E.EMPLOYEE_NAME,L.LOCATION
FROM EMPLOYEES e
RIGHT JOIN LOCATION L ON E.LOCATION_ID=L.LOCATION_ID;