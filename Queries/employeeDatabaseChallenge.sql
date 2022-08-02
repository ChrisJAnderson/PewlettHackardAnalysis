--create retirement_titles table
--retrieve emp_no, first_name, and last_name
SELECT e.emp_no,
    e.first_name,
	e.last_name,
--retrieve title, from_date, and to_date
    t.title,
    t.from_date,
    t.to_date
--join into a new table retirement_titles
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
--filter for birthdate between 1952 and 1955
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--order by emp_no
ORDER BY e.emp_no;
--starter code begins here
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.title,
rt.first_name,
rt.last_name
--create unique titles table
INTO unique_titles
FROM retirement_titles as rt
WHERE (rt.to_date="9999-01-01")
ORDER BY rt.emp_no, rt.to_date DESC;
--starter code ends here
--retrieve number of titles from unique_titles
SELECT count(ut.emp_no), ut.title
--create retiring_titles table
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
Order BY count(ut.emp_no) desc;
--create mentorship_eligibility table
SELECT DISTINCT ON(e.emp_no) e.emp_no, 
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no=de.emp_no)
INNER JOIN titles as t
ON (e.emp_no=t.emp_no)
WHERE (de.to_date='9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;