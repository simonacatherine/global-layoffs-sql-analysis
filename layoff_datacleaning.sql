SELECT * FROM layoffs;

-- 1. Remove duplicates
-- 2. Standardize the data 
-- 3. Null values or blank values
-- 4. Remove any columns 

CREATE TABLE layoffs_staging 
LIKE layoffs;

INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT *
FROM layoffs_staging;

-- 1. find duplicates

select *,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, `date`) as row_num
from layoffs_staging;
-- cant add where row_num > 1 cause where executes before window function

with duplicate_cte as
(
select *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, 
`date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
select * from duplicate_cte 
where row_num > 1;

-- make sure they are duplicates if u dont partition over every column

select * from layoffs_staging
where company = 'Hibob';

-- remove one of the duplicates (cant use delete statement on cte so we'll 
-- create a seperate table with row num and delete using where
-- right click layoffs_staging then copy to clipboard then create statement
-- then add row_num)

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging2;

insert into layoffs_staging2
select *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, 
`date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;

select * from layoffs_staging2
where row_num > 1;

delete  
from layoffs_staging2
where row_num > 1;

-- 2. standardizing data

select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select distinct industry
from layoffs_staging2
order by 1;

-- same industry with diff name 

select *
from layoffs_staging2
where industry like 'Crypto%';

update layoffs_staging2
set industry='Crypto' where industry like 'Crypto%';

select distinct location  
from layoffs_staging2
order by 1;

select * from layoffs_staging2
where location in (
	'DÃ¼sseldorf',
	'FlorianÃ³polis',
    'MalmÃ¶'
);

select distinct country  
from layoffs_staging2
order by 1;

select * 
from layoffs_staging2
where country ='United States.';

update layoffs_staging2
set country ='United States'
where country ='United States.';

-- changing date from text to date datatype
-- Y (2026) y (rounds off or something not sure)

select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

select date
from layoffs_staging2;

-- still text when we check layoff_staging2 - columns - date

alter table layoffs_staging2
modify column `date` date;

-- 3. null and blank values 

select *
from layoffs_staging2
where total_laid_off is null;

-- some has 2 column nulls that are useless

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging2
where industry is null
or industry='';

-- see if any company with blank or null for industry has a populated industry

select *
from layoffs_staging2
where company='Airbnb'; -- travel industry

select t1.industry, t2.industry
from layoffs_staging2 as t1
join layoffs_staging2 as t2
	on t1.company = t2.company
where (t1.industry is null or t1.industry ='')
and t2.industry is not null;

-- blank to null ( without this the other command wont work )

update layoffs_staging2
set industry = null
where industry = '';

-- transfrom the statement to a update statemnet

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;

-- ballys still null

select *
from layoffs_staging2
where company='Bally\'s Interactive'; -- no other row for this 

-- 4. remove any columns

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging2;

alter table layoffs_staging2
drop column row_num;

