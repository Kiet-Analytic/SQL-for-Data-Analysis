/*
   More SELECT and JOINS.
*/

--1.Create a query to display the employee number , firstname, lastname, phone number and department number.
SELECT [EMPLOYEE_ID]
      ,[FIRST_NAME]
      ,[LAST_NAME]
      ,[PHONE_NUMBER]
      ,[DEPARTMENT_ID]
  FROM [HR].dbo.[EMPLOYEES]

--2. Create q query to display the first name, last name, hiredate, salary and salary after a raise of 20%. Name the last column(salary after a raise) heading as "Anual_sal". 
SELECT [FIRST_NAME]
      ,[LAST_NAME]
      ,[HIRE_DATE]
      ,[SALARY]
      , SALARY * 1.2 AS 'Annual_sal'
  FROM [HR].[dbo].[EMPLOYEES]

--3. Create a query to display the unique manager numbers from employees table.
SELECT DISTINCT MANAGER_ID
  FROM [HR].[dbo].[EMPLOYEES]

--4. Create a query to display the last name concatenated with the first name, seperated by space, and the telephone number concatenated with the email address, seeparated by hyphen. 
--Name the column headings "FULL_NAME" and "CONTACT_DETAILS".
SELECT CONCAT(LAST_NAME, ' ', FIRST_NAME) AS 'FULL_NAME', CONCAT(PHONE_NUMBER, ' ', EMAIL) AS "CONTACT_DETAILS"
  FROM [HR].[dbo].[EMPLOYEES]

--5. Write a query to list the employees who joined in the month of April.
SELECT *
  FROM [HR].[dbo].[EMPLOYEES]
 WHERE MONTH(HIRE_DATE) = 4

--6. Write a query in SQL to list the employees of department id 50 or 110 joined in the year 1998.
SELECT *
  FROM [HR].[dbo].[EMPLOYEES]
 WHERE DEPARTMENT_ID IN (50,110)
   AND YEAR(HIRE_DATE) = 1998

--7. Write a query to list the details of employees in ascending order to the department_id and descending order to job_id
SELECT *
  FROM [HR].[dbo].[EMPLOYEES]
 ORDER BY DEPARTMENT_ID ASC, JOB_ID DESC

--8. Write a query in SQL to list the employees With Hiredate in the format like "Feb 22, 1991".
SELECT *
  FROM [HR].[dbo].[EMPLOYEES]
 WHERE FORMAT(HIRE_DATE, 'MMM,dd,yyyy') = 'Feb,22,1991'

--9. Write a query in SQL to list the employees with a salary range between 2000 to 5000 without any commission.
SELECT *
  FROM [HR].[dbo].[EMPLOYEES]
 WHERE SALARY > 2000 AND SALARY < 5000

--10. Write a query to display names of employees, whose the third letter is "a"
SELECT FIRST_NAME
  FROM [HR].[dbo].[EMPLOYEES]
 WHERE SUBSTRING(FIRST_NAME, 3,1) = 'a'

--11. Displays the names of employees with "a" , "e" in their names.
SELECT FIRST_NAME
  FROM [HR].[dbo].[EMPLOYEES]
 WHERE FIRST_NAME LIKE '%a%' AND FIRST_NAME LIKE '%e%' 

--12. Write a query to find first name, last name, department number and department name for each employees
SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_ID, d.DEPARTMENT_NAME   
FROM [HR].[dbo].[EMPLOYEES] e
JOIN [HR].[dbo].[DEPARTMENTS] d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID

--13. Write a SQL query to Find the first name, last name, department, city and state province for each employees
SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME  , l.CITY, l.STATE_PROVINCE 
FROM [HR].[dbo].[EMPLOYEES] e
JOIN [HR].[dbo].[DEPARTMENTS] d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
JOIN [HR].[dbo].[LOCATIONS] l ON l.LOCATION_ID = d.LOCATION_ID

--14. Write a query that returns the firstname of employee and their manager.
SELECT e1.FIRST_NAME AS employee_name, e2.FIRST_NAME AS manager_name
FROM [HR].[dbo].[EMPLOYEES] e1
JOIN [HR].[dbo].[EMPLOYEES] e2 ON e1.MANAGER_ID = e2. EMPLOYEE_ID

--15. Write a query to find the employees and their managers including those who have no manager return the first name of the employee and manager
SELECT e1.FIRST_NAME AS employee_name, e2.FIRST_NAME AS manager_name
FROM [HR].[dbo].[EMPLOYEES] e1
LEFT JOIN [HR].[dbo].[EMPLOYEES] e2 ON e1.MANAGER_ID = e2. EMPLOYEE_ID

--16.Write a SQL query to find those employees who work in a department where the employee of last name 'Taylor' Works. Return firstname, last name and departmentId.
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID
  FROM [HR].[dbo].[EMPLOYEES]
 WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                           FROM [HR].[dbo].[EMPLOYEES]
                          WHERE LAST_NAME = 'Taylor')

--17. Write a query to display the job title, department name, fullname and starting date for all jobs which started on or after 1st January,1993 and ending on or Before 31 August, 1997.
SELECT j.JOB_TITLE, d.DEPARTMENT_NAME, CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS FULLNAME, e.HIRE_DATE
FROM [HR].[dbo].[EMPLOYEES] e
JOIN [HR].[dbo].[DEPARTMENTS] d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
JOIN [HR].[dbo].[JOBS] j ON j.JOB_ID = e.JOB_ID
WHERE e.HIRE_DATE > '1993-01-01' AND e.HIRE_DATE < '1997-08-31'

--18.Write a query to display employee name, job_id, department_id and department_name for all employees working in Toronto.
SELECT e.FIRST_NAME, e.JOB_ID, e.DEPARTMENT_ID, d.DEPARTMENT_NAME
FROM [HR].[dbo].[EMPLOYEES] e
JOIN [HR].[dbo].[DEPARTMENTS] d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
JOIN [HR].[dbo].[LOCATIONS] l ON l.LOCATION_ID = d.LOCATION_ID
WHERE l.CITY = 'Toronto'

--19. Write a query to the employee's name, hire_date of employees who has hire_date after Davies's hire_date
SELECT FIRST_NAME, HIRE_DATE
FROM [HR].[dbo].[EMPLOYEES]
WHERE HIRE_DATE > (SELECT HIRE_DATE
                     FROM [HR].[dbo].[EMPLOYEES]
                    WHERE LAST_NAME = 'Davies')

--20.Write a query to display employee name and hire_date of employees who were hired before their manager, along with the manager's name and their hire_date. The labels of the columns are Employee, Emp Hired, Manager, Mrg Hired.
SELECT e1.FIRST_NAME AS Employee, e1.HIRE_DATE AS 'Emp Hired', e2.FIRST_NAME AS Manager, e2.HIRE_DATE AS 'Mgr Hired'
FROM [HR].[dbo].[EMPLOYEES] e1
JOIN [HR].[dbo].[EMPLOYEES] e2 ON e1.MANAGER_ID = e2. EMPLOYEE_ID
WHERE e1.HIRE_DATE > e2.HIRE_DATE