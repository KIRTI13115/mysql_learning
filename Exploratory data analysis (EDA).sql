-- EDA

SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MIN(total_laid_off)
FROM layoffs_staging2;

SELECT MAX(percentage_laid_off), MIN(percentage_laid_off)
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL;

-- companies where percentage laid off was 1
SELECT company, industry, location
FROM layoffs_staging2
WHERE percentage_laid_off = 1;

-- funds raised by companies who went down completely
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;


--  looking at companies with highest layoffs daywise

SELECT company,total_laid_off
FROM layoffs_staging2
ORDER BY total_laid_off DESC
LIMIT 5;

-- looking at companies with highest layoffs overall(over all years for which data is present)

SELECT company,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY SUM(total_laid_off) DESC
LIMIT 5;

-- by location
SELECT location,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY location
ORDER BY SUM(total_laid_off) DESC
LIMIT 5;

-- by country
SELECT country,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY SUM(total_laid_off) DESC
LIMIT 5;


SELECT MAX(`date`),MIN(`date`)
FROM layoffs_staging2;


-- yearwise max laid off
SELECT YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY SUM(total_laid_off) DESC;

-- looking at trends of layoffs by months or years

SELECT substring(`date`,6,2) as MONTHS,SUM(total_laid_off)
FROM layoffs_staging2
WHERE substring(`date`,6,2) is not null
GROUP BY MONTHS
ORDER BY MONTHS;

SELECT substring(`date`,1,7) as MONTHS,SUM(total_laid_off)
FROM layoffs_staging2
WHERE substring(`date`,1,7) is not null
GROUP BY MONTHS
ORDER BY SUM(total_laid_off) DESC;

SELECT industry,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY SUM(total_laid_off) DESC;

SELECT stage,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY SUM(total_laid_off) DESC;

-- looking at progressions 

-- filtering top 5 companies with highest layoffs per year
WITH Company_Table(company, years, total_laid_off) AS
(SELECT company , YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
WHERE YEAR(`date`) is not null
GROUP BY company,YEAR(`date`)
ORDER BY SUM(total_laid_off) DESC
), Company_Ranking AS
(SELECT company , years, total_laid_off, 
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM Company_Table)
SELECT *
FROM Company_Ranking
WHERE ranking <=5 ;

-- rolling_layoffs

SELECT SUBSTRING(`date`,1,7) as dates, SUM(total_laid_off) AS total
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) is not null
GROUP BY dates
ORDER BY dates ;

WITH Rolling_layoffs as
(SELECT SUBSTRING(`date`,1,7) as dates, SUM(total_laid_off) AS total
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) is not null
GROUP BY dates
ORDER BY dates
)
SELECT dates, SUM(total) OVER(ORDER BY dates) as rolling_sum
FROM ROlling_layoffs
ORDER BY dates;
