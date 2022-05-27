--------Challenge--------Deliv.1--------
-- get the titles of current employees who were born between
select e.emp_no,
		e.first_name,
		e.last_name,
		ti.title,
		ti.from_date,
		ti.to_date
---into retirement_titles
from employees as e
inner join titles as ti
on e.emp_no = ti.emp_no
where e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
order by e.emp_no;

----- Use Dictinct with Orderby to remove duplicate rows
----- 

SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
--INTO unique_titles
FROM retirement_titles
WHERE to_date='9999-01-01'
ORDER BY emp_no, to_date DESC;

-- Get the count of the retiring titles
SELECT COUNT (ut.title), ut.title
--INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.count DESC;

--------Challenge--------Deliv.2--------

-- get the current employees mentorship-eligibility table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
 AND (de.to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

-- Get the number of retiring titles by department
select ut.emp_no,
		ut.first_name,
		ut.last_name,
		d.dept_name
into dept_retiring
from unique_titles as ut
INNER JOIN dept_emp as de
ON ut.emp_no = de.emp_no
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
order by ut.emp_no;

SELECT COUNT (dr.dept_name), dr.dept_name
INTO retiring_dept_count
FROM dept_retiring as dr
GROUP BY dr.dept_name
ORDER BY dr.count DESC;

-- Get the count of mentorship eligibilty by department 
select me.emp_no,
		me.first_name,
		me.last_name,
		me.title,
		d.dept_name
into mentorship_by_dept
from mentorship_eligibilty as me
INNER JOIN dept_emp as de
ON me.emp_no = de.emp_no
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
order by me.emp_no;

SELECT COUNT (me.dept_name), me.dept_name
INTO mentorship_dept_count
FROM mentorship_by_dept as me
GROUP BY me.dept_name
ORDER BY me.count DESC;