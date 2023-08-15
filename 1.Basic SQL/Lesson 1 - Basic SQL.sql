/*  
    1st WORKING TABLE : World
*/

--1.show the population of Germany
SELECT population 
  FROM world
 WHERE name = 'Germany';

--2.Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.
SELECT name, population 
  FROM world
 WHERE name IN ('Sweden', 'Norway', 'Denmark');

--3.Show the country and the area for countries with an area between 200,000 and 250,000.
 SELECT name, area 
   FROM world
  WHERE area BETWEEN 200000 AND 250000;

--4.Show the country name and the population for countries with an area between 1,000,000 and 1,250,000.
SELECT name, population
  FROM world
 WHERE population BETWEEN 1000000 AND 1250000;

--5.Write a query to show the country name, the population of countries start with 'Al' in their name.
SELECT name, population
  FROM world
 WHERE name LIKE "Al%";

--6.Write a query to show the countries that end in 'a' or 'l'.
SELECT name
  FROM world
 WHERE name LIKE '%a' OR name LIKE '%l';

--7.Write a query to show the country and the length of the countries name which is in Europe and having length of name equal to 5.
SELECT name,length(name)
  FROM world
 WHERE length(name)=5 and region='Europe';

--8. Write a query to show the countries with an area larger than 50000 and a population smaller than 10000000. Including name, area and population.
 SELECT name, area, population
  FROM world
 WHERE area > 50000 AND population < 10000000;

--9. Write a query that shows the population density of China, Australia, Nigeria and France. Including the name and the population density in result.
SELECT name, population/area
  FROM world
 WHERE name IN ('China', 'Nigeria', 'France', 'Australia');

--10.Show the name, continent and population of all countries.
 SELECT name, continent, population 
   FROM world;

--11.Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.
SELECT name 
 FROM world
WHERE population >= 200000000;

--12.Give the name and the per capital GDP for those countries with a population of at least 200 million.
SELECT name, gdp/population
  FROM world
 WHERE population >= 200000000;

--13.Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.
SELECT name, population/1000000
FROM world
WHERE continent LIKE 'South America';

--14.Show the name and population for France, Germany, Italy.
SELECT name, population
FROM world
WHERE name in ('France', 'Germany', 'Italy');

--15.Show the countries which have a name that includes the word 'United'.
SELECT name
  FROM world
 WHERE name LIKE '%United%';

--16.Show the countries that are big by area or big by population. Show name, population and area. 
-- Two ways to be big: A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million.

SELECT name, population, area
  FROM world
 WHERE area > 3000000 OR population > 250000000;

--17.Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. 
-- Show name, population and area.
SELECT name, population, area
  FROM world
 WHERE population > 250000000 AND  area < 3000000
    OR population < 250000000 AND area > 3000000;

--18.Show per-capita GDP (Round this value to the nearest 1000) for the trillion dollar countries to the nearest $1000.
SELECT name, round(gdp/population, -3)
FROM world
WHERE gdp >= 1000000000000;

--19.Show the name and capital where the name and the capital have the same number of characters.
SELECT name, capital
  FROM world
 WHERE LEN(name) = LEN(capital)

--20.Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
SELECT name, capital
 FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1)
  AND name <> capital;

--21.Find the country that has all the vowels and no spaces in its name. 
SELECT name 
FROM world
WHERE name LIKE '%a%' 
  AND name LIKE '%e%'
  AND name LIKE '%i%'
  AND name LIKE '%o%'
  AND name LIKE '%u%'
  AND name NOT LIKE '% %';

--22.Write a query that shows the name of countries beginning with U
SELECT name
FROM world
WHERE name LIKE 'U%';

--23.Write a query which shows just the population of United Kingdom?
SELECT population
  FROM world
 WHERE name = 'United Kingdom';

--24.Write a query which would reveal the name and population of countries in Europe and Asia
SELECT name, population
  FROM world
 WHERE continent IN ('Europe', 'Asia');

--25. Show the country with the population greater than 40,000,000 and in South America.
SELECT name FROM world
 WHERE continent = 'South America'
   AND population > 40000000;

/*   
    2nd WORKING TABLE: Nobel
*/

--1.Write a query so that it displays Nobel prizes for 1950. Including year, subject, winner.
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950;

--2.Show who won the 1962 prize for literature.
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'literature';

--3.Show the year and subject that won 'Albert Einstein' his prize.
SELECT yr, subject
  FROM nobel
 WHERE winner = 'Albert Einstein';

--4.Give the name of the 'peace' winners since the year 2000, including 2000.
SELECT winner
 FROM nobel
WHERE subject = 'peace' AND yr >= 2000;

--5.Show all details (yr, subject, winner) of the literature prize winners for 1980 to 1989 inclusive.
SELECT *
  FROM nobel
 WHERE subject = 'literature' AND (yr >= 1980 AND yr <= 1989); 

--6. Show all details of the presidential winners: Theodore Roosevelt, Woodrow Wilson ,Jimmy Carter, Barack Obama.
SELECT * 
  FROM nobel
 WHERE winner IN ('Theodore Roosevelt', 'Thomas Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');

--7. Show the winners with first name John
SELECT winner
  FROM nobel
 WHERE winner LIKE 'John%';

--8.Show the year, subject, and name of physics winners for 1980 together with the chemistry winners for 1984.
SELECT *
  FROM nobel
 WHERE (subject = 'physics' AND yr = 1980)
    OR (subject = 'chemistry' AND yr = 1984);

--9.Show the year, subject, and name of winners for 1980 excluding chemistry and medicine.
SELECT *
  FROM nobel
 WHERE subject NOT IN ('chemistry', 'medicine') AND yr = 1980;

--10.Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together 
--With winners of a 'Literature' prize in a later year (after 2004, including 2004).
SELECT *
  FROM nobel
 WHERE (subject = 'Medicine' AND yr < 1910)
    OR (subject = 'Literature' AND yr >= 2004);

--11.Find all details of the prize won by PETER GRÜNBERG
SELECT *
FROM nobel
WHERE winner LIKE '%PETER GR%';

--12.Find all details of the prize won by EUGENE O'NEILL.
SELECT *
  FROM nobel
 WHERE winner = 'EUGENE O"NEILL';

--13.List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.
SELECT winner, yr, subject
  FROM nobel
 WHERE winner LIKE 'Sir%'
 ORDER BY yr DESC, winner ASC;

--14.Show the 1984 winners and subject ordered by subject and winner name; but list chemistry and physics last.
 SELECT winner, subject
  FROM nobel
 WHERE yr = 1984
 ORDER BY  
     CASE 
        WHEN subject IN ('chemistry','physics') THEN 1 
        ELSE 0 END, 
        subject, winner
;    

--15.Write a query that shows the name of winner's names beginning with C and ending in n
SELECT winner 
  FROM nobel
 WHERE winner LIKE 'C%' AND winner LIKE '%n';

--16.Write a query that shows how many Chemistry awards were given between 1950 and 1960.
SELECT COUNT(subject) 
  FROM nobel
 WHERE subject = 'Chemistry'
   AND yr BETWEEN 1950 and 1960;

--17. Pick the code that shows the amount of years where no Medicine awards were given
SELECT COUNT(DISTINCT yr) 
  FROM nobel
 WHERE yr NOT IN (SELECT DISTINCT yr FROM nobel WHERE subject = 'Medicine');

--18.Write a query which would show the year when neither a Physics or Chemistry award was given.
SELECT yr 
  FROM nobel
 WHERE yr NOT IN (SELECT yr 
                   FROM nobel
                  WHERE subject IN ('Chemistry','Physics')
                  );

--19.Select the code which shows the years when a Medicine award was given but no Peace or Literature award was.
SELECT DISTINCT yr
  FROM nobel
 WHERE subject = 'Medicine' 
   AND yr NOT IN (SELECT yr 
                    FROM nobel
                   WHERE subject='Literature')
   AND yr NOT IN (SELECT yr
                    FROM nobel
                   WHERE subject='Peace')
;
