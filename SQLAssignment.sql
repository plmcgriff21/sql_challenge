--Delete tables as needed 
DROP TABLE departments 
DROP TABLE dept_emp
DROP TABLE dept_manager
DROP TABLE employees
DROP TABLE salaries 
DROP TABLE titles
---------------------------------------------------------------------------------------------------------------------
--Create table for departments
CREATE TABLE departments(dept_no VARCHAR, dept_name VARCHAR(200));
SELECT * FROM departments
--Create table for dept_emp
CREATE TABLE dept_emp(emp_no INT,dept_no VARCHAR);
SELECT * FROM dept_emp
--Create table for dept_manager
CREATE TABLE dept_manager(dept_no VARCHAR, emp_no INT);
SELECT * FROM dept_manager
--Create table for employees
CREATE TABLE employees(emp_no INT, emp_title_id VARCHAR, birth_date DATE, first_name VARCHAR, last_name VARCHAR, sex VARCHAR, hire_date DATE);
SELECT * FROM employees
--Create table for salaires 
CREATE TABLE salaries( emp_no INT, salary DEC);
SELECT * FROM salaries
--Create table for titles 
CREATE TABLE titles(title_id VARCHAR, title VARCHAR);
SELECT * FROM titles

--Import CSV data and refresh tables
---------------------------------------------------------------------------------------------------------------------
--Link salary and employees table to display data from both employees info and the salary table
SELECT last_name,first_name,sex, salary
FROM employees
INNER JOIN salaries
ON employees.emp_no=salaries.emp_no;
--Identify employees that were hired in 1986
SELECT first_name,last_name,hire_date
FROM employees 
WHERE hire_date>='01-01-1986%' AND hire_date <='12-31-1986';
---------------------------------------------------------------------------------------------------------------------
--List the manager of each department with the following information: department number, 
--department name, the manager's employee number, last name, first name.
--Department name, dept_no,and manager's employee ID
SELECT dept_manager.dept_no,emp_no, dept_name
FROM dept_manager
INNER JOIN departments
ON departments.dept_no = dept_manager.dept_no;

--First and last name of Manager 
SELECT first_name, last_name, emp_no
FROM employees 
WHERE emp_no IN(SELECT emp_no
FROM dept_manager
INNER JOIN departments
ON departments.dept_no = dept_manager.dept_no);

SELECT first_name, last_name, employees.emp_no, dept_emp.dept_no, dept_name
FROM employees 
INNER JOIN dept_emp ON dept_emp.emp_no=employees.emp_no
INNER JOIN departments ON dept_emp.dept_no=departments.dept_no
WHERE employees.emp_no IN (SELECT emp_no
FROM dept_manager
INNER JOIN departments
ON departments.dept_no = dept_manager.dept_no);
---------------------------------------------------------------------------------------------------------------------
--List the department of each employee
SELECT first_name, last_name,dept_name
FROM employees 
INNER JOIN dept_emp ON dept_emp.emp_no=employees.emp_no
INNER JOIN departments ON dept_emp.dept_no=departments.dept_no
---------------------------------------------------------------------------------------------------------------------
--List of employees named Hercules whose last names start with B
SELECT first_name, last_name, sex
FROM employees
WHERE first_name='Hercules'AND last_name LIKE 'B%';
---------------------------------------------------------------------------------------------------------------------
---Employees in the Sales Department 
SELECT employees.emp_no, last_name, first_name, dept_name
FROM employees 
INNER JOIN dept_emp ON dept_emp.emp_no=employees.emp_no
INNER JOIN departments ON dept_emp.dept_no=departments.dept_no
WHERE dept_name = 'Sales'
---------------------------------------------------------------------------------------------------------------------
--Employees in the Sales and Development departments 
SELECT employees.emp_no, last_name, first_name, dept_name
FROM employees 
INNER JOIN dept_emp ON dept_emp.emp_no=employees.emp_no
INNER JOIN departments ON dept_emp.dept_no=departments.dept_no
WHERE dept_name = 'Sales' OR dept_name='Development'
---------------------------------------------------------------------------------------------------------------------
--Count of shared last names
SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name


