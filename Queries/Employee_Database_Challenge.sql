SELECT * FROM titles;

-- Create a table that include retiree titles
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles 
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no, to_date;

-- Use Dictinct with Orderby to remove duplicates
SELECT DISTINCT ON (rt.emp_no) rt.emp_no, 
	rt.first_name, 
	rt.last_name,
	rt.title
INTO unique_titles 
FROM retirement_titles AS rt
ORDER BY emp_no, to_date DESC;

-- Count by Title
SELECT COUNT(u.emp_no), u.title 
INTO retiring_titles
FROM unique_titles AS u
GROUP BY u.title
ORDER BY count DESC;

-- Creating a table of eligible maybe-mentors
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01') AND 
	(e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

SELECT * FROM titles
