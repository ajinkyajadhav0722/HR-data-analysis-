USE hr_data;
select * from hr;
alter table hr
change column ï»¿id emp_id varchar(20)null;

describe hr;
select birthdate from hr;

set sql_safe_updates = 0;
update hr
set birthdate = CASE 
	when birthdate like '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y'),'%Y-%m-%d')
    when birthdate like '%/%' then date_format(str_to_date(birthdate, '%m-%d-%Y'),'%Y-%m-%d')
    else null
end;






alter table hr
modify column birthdate date;





UPDATE hr
SET hire_date = 
    CASE
        WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
        WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
        ELSE NULL
    END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;



ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM hr;









    
UPDATE hr 
SET termdate = DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL 
AND termdate != ' ' 
AND termdate != '';
    
    
    
select termdate from hr;

DELETE FROM hr WHERE termdate = '';
UPDATE hr SET termdate = NULL WHERE termdate = '';
ALTER TABLE hr MODIFY COLUMN termdate DATE;




SELECT 
  CASE 
    WHEN age >= 18 AND age <= 24 THEN '18-24'
    WHEN age >= 25 AND age <= 34 THEN '25-34'
    WHEN age >= 35 AND age <= 44 THEN '35-44'
    WHEN age >= 45 AND age <= 54 THEN '45-54'
    WHEN age >= 55 AND age <= 64 THEN '55-64'
    ELSE '65+' 
  END AS age_group, 
  COUNT(*) AS count
FROM 
  hr
WHERE 
  age >= 18
GROUP BY age_group
ORDER BY age_group;




SELECT 
  CASE 
    WHEN age >= 18 AND age <= 24 THEN '18-24'
    WHEN age >= 25 AND age <= 34 THEN '25-34'
    WHEN age >= 35 AND age <= 44 THEN '35-44'
    WHEN age >= 45 AND age <= 54 THEN '45-54'
    WHEN age >= 55 AND age <= 64 THEN '55-64'
    ELSE '65+' 
  END AS age_group, gender,
  COUNT(*) AS count
FROM 
  hr
WHERE 
  age >= 18
GROUP BY age_group, gender
ORDER BY age_group, gender;


SELECT location, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY location;


SELECT 
    department, 
    ROUND(AVG(DATEDIFF(CURDATE(), termdate)/365),0) as avg_tenure 
FROM 
    hr 
WHERE 
    termdate <= CURDATE() 
    AND termdate <> '0000-00-00' -- Exclude rows with '0000-00-00' termdate
    AND age >= 18 
GROUP BY 
    department 
LIMIT 0, 1000;