-- data cleaning project
-- data cleaning is a process of converting raw data into useful data so that visualizations can be performed on it

-- https://www.kaggle.com/datasets/swaptr/layoffs-2022 - used the data from here

SELECT *
FROM layoffs;

-- before manipulating data we would copy the raw table into other tables so that we always have access to raw data

CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT INTO layoffs_staging
SELECT * 
FROM layoffs;

SELECT *
FROM layoffs_staging;


-- 1. first thing we would do is remove duplicates
-- since here we dont hve any column containing unique ids type thing we would use row number concept to remove duplicates

SELECT *,
ROW_NUMBER() OVER(partition by company, 
location, industry, total_laid_off, percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging;

WITH rem_dup AS
(SELECT *,
ROW_NUMBER() OVER(partition by company, 
location, industry, total_laid_off, percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM rem_dup
WHERE row_num > 1;

-- this gives us all the rows that have duplicates 
-- to remove these duplicates we cannot just write delete in above cte as we cannot perform update operations on ctes
-- so we create new table which have new column tht is row_num and then delete rows where it is more than 1

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

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(partition by company, 
location, industry, total_laid_off, percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE 
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

-- hence duplicates are now removed but we got this new row ie row_num which will t5ake up memory space so we would need to delete it in the end

-- 2. Next is standardizing data - to make things all uppercase or all lowercase or spellings 
SELECT DISTINCT industry
FROM layoffs_staging2
ORDer BY 1;

UPDATE layoffs_staging2
SET company = TRIM(company);

UPDATE layoffs_staging2
SET country = TRIM(trailing '.' FROM country);

-- converting datatype of date from text to date and changing the format to standard format of dates in mysql

UPDATE layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';


-- 3. third step is to deal with nulls and blanks

SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL ;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL ;

-- other null values in total_laid_off column and percentage_lid_off column cannot be populated because we dont no any method to do so if we would have known total population we could have used it but right now let it just as it is

-- 4. last step is to remove not required rows or columns
-- in this staging table we have companies with null total layouts and percentage_layoffs, we cannot be sure that they are useless but for our purpose to study the layoffs they are of no significance so we can delete them

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;


DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

-- lastly remove row_num column

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT * 
FROM layoffs_staging2;

-- at the end layoff_staging2 is our cleaned table 






 
