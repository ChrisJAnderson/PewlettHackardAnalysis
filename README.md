# PewlettHackardAnalysis
 ## Project Overview
 The purpose of this project is to break down employee data for a large company (Pewlett-Hackard) in order to generate insights into an upcoming wave of retirements. Our data gives a concise picture of where the company needs to focus hiring and training efforts in order to ensure adequate staffing across all departments as older employees begin to retire.
 We do this by assembling and querying an SQL database to assemble several sets of relevant information, while trimming out the data that could distract from the relevant information- for example, employees too young to retire or employees that are still in the company database but no longer employed.
 ## Results
 - One insight we can get from the analysis is the nature of the positions set for retirement. This is done by comparing two sets of data- our retiring_titles table and a table produced by this query:
 >select count(emp_no),title from titles
 >where (to_date='9999-01-01')
 >group by title
 Retirements at Pewlett-Hackard will be across the board for the most part, affecting every job title, not only the senior positions. Hiring will accordingly have to be across the board, offering plenty of opportunity to onboard junior or entry level members of the workforce who can potentially remain with Pewlett-Hackard for a long time.
 - We can also see what positions will need the most restaffing, from the retiring_titles table. The title with the highest number of retirees is Senior Engineer, followed by Senior Staff. Promotions may be in order at Pewlett-Hackard as well! ![](/Images/readme1.png)
 - In the image above we also see two manager positions will potentially be opening up. Two isn't a large number compared to, for example, the senior staff count of 24926, but manager positions represent a significant responsibility and investment in training. I'll also revisit this problem as one of my additional queries in the next section.
 - Training is something that's going to be in high demand for Hewlett-Packard as well. Our mentorship_eligibility table produces another list of employees set to retire who are considered capable of training the next generation of employees, and the numbers are bleak. For our highest retiring position, Senior Engineer, we have 268 eligible mentors and potentially almost 26000 positions opening up.![](/Images/readme2.png)
 ## Summary
 Pewlett-Hackard is looking at filling 72,458 positions as older employees across the company begin to retire. While these positions are largely senior positions, there is plenty of opportunity to hire less senior positions as well, and invest in junior and entry level workers who will remain with the company for a long time.
 However, we also have to consider the number of employees eligible to mentor the next generation of workers. There are not nearly enough mentors for the amount of positions that must be filled. Within the senior engineer job title, for example, there are almost 26000 employees set to retire, and only 268 of them are eligible to mentor new workers. This gives each senior engineer mentor approximately one hundred fresh-faced senior engineers to mentor before they can retire. Even among t he less extreme retirement rates of our approximately 290 staff mentors are still responsible for 25 staff members each. 
 
 One additional question I would like answered in this analysis is staff eligible for taking up the two missing management positions. To do this, I'll write two queries- the first to find out which of our managers are set to retire, and the second to assemble a list of employees eligible for promotion who are not eligible for retirement.
 The first query we use is this:
 >select ut.first_name,
 >ut.last_name,
 >dm.dept_no,
 >d.dept_name
 >into retiring_managers
 >from unique_titles as ut
 >inner join dept_emp as dm
 >on(ut.emp_no=dm.emp_no)
 >inner join departments as d
 >on (dm.dept_no=d.dept_no)
 >where (ut.title='Manager');
 This query extracts the first name, last name, department number, and department name for our retiring managers and shows us the two positions that need to be filled: Manager of Sales and Manager of Research.

 To find out who can fill these positions we make another two queries to the database, which read as follows: 
>select ce.emp_no,
>ce.first_name, 
>ce.last_name,
>de.dept_no,
>e.hire_date
>into d007_manager_candidates 
>from current_emp as ce
>inner join dept_emp as de 
>on(ce.emp_no=de.emp_no)
>inner join employees as e
>on (ce.emp_no=de.emp_no)
>where (e.hire_date between '1990-01-01' and '2005-12-31')
>	and(de.dept_no='d007')
>	and (de.to_date='9999-01-01')

>select ce.emp_no,
>ce.first_name, 
>ce.last_name,
>de.dept_no,
>e.hire_date
>into d008_manager_candidates 
>from current_emp as ce
>inner join dept_emp as de 
>on(ce.emp_no=de.emp_no)
>inner join employees as e
>on (ce.emp_no=de.emp_no)
>where (e.hire_date between '1990-01-01' and '2005-12-31')
	>and(de.dept_no='d008')
	>and (de.to_date='9999-01-01')
Unfortunately, running these queries crashed my pgadmin, so perhaps the best course of action is just to ask our retiring Managers of Sales and Research who they recommend for a replacement.