
-- Create new table
DROP table departments;
CREATE TABLE departments (
	dept_no VARCHAR PRIMARY KEY,
	dept_name VARCHAR
);

--select whole table
SELECT * FROM departments;

--create new table
drop table employees;
CREATE TABLE employees (
	emp_no INT PRIMARY KEY,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	gender VARCHAR,
	hire_date DATE
);
--select whole table
SELECT * FROM employees;

--create new table
drop table dept_manager;
CREATE TABLE dept_manager (
	dept_no VARCHAR,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	from_date VARCHAR,
	to_date VARCHAR,
	PRIMARY KEY (dept_no, emp_no)
);
--select whole table
SELECT * FROM dept_manager;

--create table
drop table dept_emp;

CREATE TABLE dept_emp (
	emp_no int,
	dept_no varchar,
	from_date varchar,
	to_date varchar,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

SELECT * FROM dept_emp;

--create table
drop table salaries;
CREATE TABLE salaries (
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary VARCHAR,
	from_date VARCHAR,
	to_date VARCHAR,
	PRIMARY KEY (emp_no)	
);
--select whole table
SELECT * FROM salaries;

--create table
drop table titles;
CREATE TABLE titles (
	emp_no INT,
	title VARCHAR,
	from_date VARCHAR,
	to_date VARCHAR,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);
--select whole table
SELECT * FROM titles

--List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT salaries.emp_no, employees.first_name, employees.last_name, employees.gender, salaries.salary
FROM employees
INNER JOIN salaries ON
employees.emp_no=salaries.emp_no;
 
--subquery to get the names of employees who started working in 1986 --smth is wrong here
SELECT first_name, last_name
FROM employees
WHERE emp_no IN
(
  SELECT emp_no
  FROM dept_emp
  WHERE from_date IN
  (
    SELECT from_date
    FROM dept_emp
    WHERE from_date LIKE '1986%'
  )
);

--managers with department number, department name, the manager's employee number, last name, first name,
--and start and end employment dates

SELECT employees.emp_no, departments.dept_no, employees.first_name, employees.last_name, dept_manager.from_date, dept_manager.to_date, departments.dept_name
FROM employees
INNER JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
INNER JOIN departments ON departments.dept_no = dept_manager.dept_no

--list the department of each employee with the following information:
--employee number, last name, first name, and department name.
		
SELECT employees.emp_no, departments.dept_no, employees.first_name, employees.last_name
FROM employees
INNER JOIN departments ON departments.dept_no = departments.dept_no;

--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT employees.first_name, employees.last_name FROM employees
WHERE employees.first_name IN ('Hercules') AND employees.last_name LIKE 'B%'

--List all employees in the Sales department, including their employee number,
--last name, first name, and department name.

SELECT employees.emp_no, departments.dept_name, employees.first_name, employees.last_name
FROM employees
INNER JOIN departments ON departments.dept_name = departments.dept_name
WHERE departments.dept_name = 'Sales'

--List all employees in the Sales and Development departments, including their employee number, 
--last name, first name, and department name.

SELECT e.emp_no, d.dept_name, e.first_name, e.last_name
FROM employees e
JOIN dept_emp f ON e.emp_no = f.emp_no
JOIN departments d ON f.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Departments')

--In descending order, list the frequency count of employee last names, i.e.,
--how many employees share each last name.
SELECT last_name, COUNT(last_name)  AS "count of last names" FROM employees
GROUP BY last_name
ORDER BY "count of last names" DESC
