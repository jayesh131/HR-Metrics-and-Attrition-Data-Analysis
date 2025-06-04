create database Hrdata
use Hrdata

SELECT * FROM data;

-- Total Count Of employees
SELECT COUNT(*) AS total_employees FROM data;

-- Gender Distribution
SELECT Gender, COUNT(*) AS count FROM data GROUP BY Gender;

-- Intermediate - Average Monthly_Income by Department
SELECT Department, AVG(Monthly_Income) AS avg_income
FROM data
GROUP BY Department;

-- Count of Employees by Job Role and Gender
SELECT Job_Role, Gender, COUNT(*) AS count
FROM data
GROUP BY Job_Role, Gender
ORDER BY Job_Role;

-- Attribution Rate by Department
SELECT Department,
       COUNT(*) AS total_employees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attritions,
       ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM data
GROUP BY Department;

-- Age Group Segmentation with Attrition Rate
SELECT 
  CF_age_band AS age_group,
  COUNT(*) AS total,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attritions,
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM data
GROUP BY CF_age_band
ORDER BY CF_age_band;

-- Department vs. Job Role Matrix
SELECT Department, Job_Role, COUNT(*) AS count
FROM data
GROUP BY Department, Job_Role
ORDER BY Department, count DESC;

-- Cumulative Attrition Over Years at Company
SELECT Years_At_Company,
       COUNT(*) AS total_employees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attritions,
       ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM data
GROUP BY Years_At_Company
ORDER BY Years_At_Company;

-- Identify High Attrition Job Roles (Rate > 20%)
SELECT Job_Role,
       COUNT(*) AS total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attritions,
       ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM data
GROUP BY Job_Role
HAVING attrition_rate > 20;

-- Monthly Income Distribution by Attrition
SELECT 
  CASE
    WHEN Monthly_Income < 3000 THEN '< 3000'
    WHEN Monthly_Income BETWEEN 3000 AND 6000 THEN '3000-6000'
    WHEN Monthly_Income BETWEEN 6001 AND 9000 THEN '6001-9000'
    ELSE '> 9000'
  END AS income_range,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attritions
FROM data
GROUP BY income_range
ORDER BY income_range;

