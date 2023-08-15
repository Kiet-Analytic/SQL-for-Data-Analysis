/*  
    1st WORKING TABLE : World
*/

--1.Show the total population of the world.
SELECT SUM(population)
  FROM world

--2.List all the continents - just once each.
SELECT continent
FROM world
GROUP BY continent

--3.Give the total GDP of Africa.
SELECT SUM(gdp)
  FROM world
 WHERE continent = 'Africa'

--4.How many countries have an area of at least 1000000.
SELECT COUNT(name)
  FROM world
 WHERE area >= 1000000

 --5.What is the total population of ('Estonia', 'Latvia', 'Lithuania').
SELECT SUM(population)
  FROM world
 WHERE name IN ('Estonia', 'Latvia', 'Lithuania')

--6.For each continent show the continent and number of countries.
SELECT continent, COUNT(name)
  FROM World
 GROUP BY continent

--7.For each continent show the continent and number of countries with populations of at least 10 million.
SELECT continent, COUNT(name)
  FROM world
 WHERE population > 10000000
 GROUP BY continent

--8.List the continents that have a total population of at least 100 million.
SELECT continent, SUM(population)
  FROM world
 GROUP BY continent
HAVING SUM(population) >= 100000000

--9.Write a query shows the sum of population of all countries in 'Europe'.
SELECT SUM(population)
FROM world
WHERE region = 'Europe'

--10.Write a query shows the number of countries with population smaller than 150000.
SELECT COUNT(name)
  FROM world
WHERE population < 150000

--11.Write a query shows the average population of 'Poland', 'Germany' and 'Denmark'.
SELECT AVG(population) FROM world 
 WHERE name IN ('Poland', 'Germany', 'Denmark');

--12.Write a query shows the medium population density of each region.
SELECT region, SUM(population) / SUM(area)
  FROM World
 GROUP BY region

--13.Write a query shows the name and population density of the country with the largest population
SELECT name, population/area AS density
  FROM World
 WHERE population = (SELECT MAX(population) FROM world);

--14.List each country name where the population is larger than that of 'Russia'.
SELECT name
  FROM world
 WHERE population > (SELECT population FROM world WHERE name = 'Russia');

--15. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name
FROM world
WHERE continent = 'Europe'
  AND gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom');

--16.List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name, continent
  FROM world
 WHERE continent IN (SELECT continent FROM world WHERE name IN ('Argentina', 'Australia'));
 ORDER BY name ASC;

--17.Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.
SELECT name, population
FROM world
WHERE population > (SELECT population FROM world where name = 'United Kingdom')
  AND population < (SELECT population FROM world where name = 'Germany')

--18.Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany
SELECT name, CONCAT(ROUND(population * 100 / (SELECT population FROM world WHERE name = 'Germany')), '%') AS percentage
FROM world
WHERE continent = 'Europe';

--19.Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
SELECT name
  FROM world
 WHERE gdp > (SELECT MAX(gdp) FROM world WHERE continent = 'Europe')

--20.Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT continent, name , MAX(area)
  FROM world
 GROUP BY continent

SELECT continent, name, area
  FROM world w1
 WHERE area = (SELECT max(area)
                 FROM world w2
                WHERE w2.continent = w1.continent)

--21.List each continent and the name of the country that comes first alphabetically.
SELECT continent, name
  FROM world w1
 WHERE name = (SELECT name
                 FROM world w2
                WHERE w2.continent = w1.continent
                ORDER BY name
                LIMIT 1); 

SELECT continent, MIN(name)
  FROM world
 GROUP BY continent;

--22.Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
SELECT name, continent, population
  FROM world w1
 WHERE 25000000 >= ALL(SELECT population
                         FROM world w2
                        WHERE w2.continent = w1.continent);  

SELECT continent, name, population
FROM world
WHERE continent IN (SELECT continent 
                      FROM world
                     GROUP BY continent
                    HAVING MAX(population) <= 25000000);

--23.Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.
SELECT name, continent
FROM world w1
WHERE w1.population / 3 > ALL(SELECT population
                             FROM world w2
                            WHERE w2.continent = w1.continent AND w2.name <> w1.name)

--24.Shows the name, region and population of the smallest country in each region
SELECT region, name, population 
  FROM world w1 
  WHERE population <= ALL (SELECT w2.population 
                             FROM world w2 
                            WHERE w2.region=w1.region AND w2.population>0)

--25.Shows the countries belonging to regions with all populations over 50000.
SELECT name,region,population 
  FROM world w1 WHERE 50000 < ALL (SELECT w2.population 
                                     FROM world w2 
                                    WHERE w2.region=w1.region AND w2.population>0)

--26.Shows the countries with a less than a third of the population of the countries around it
SELECT name, population
FROM world w1
WHERE w1.population  < ALL(SELECT w2.population
                             FROM world w2
                             WHERE w2.continent = w1.continent AND w2.name = w1.name)

--27.Show the countries with a greater GDP than any country in Africa (some countries may have NULL gdp values).
SELECT name
  FROM world w1
 WHERE gdp > (SELECT MAX(gdp) FROM world WHERE continent = 'Africa')

--28. shows the countries with population smaller than Russia but bigger than Denmark.
SELECT name FROM world
 WHERE population < (SELECT population FROM world WHERE name='Russia')
   AND population > (SELECT population FROM world WHERE name='Denmark')

--29. Show countries in South Asia with population greater than all countries belong to Europe.
SELECT name 
  FROM world
 WHERE region = 'South Asia'
   AND population > (SELECT MAX(population)
                       FROM bbc
                      WHERE region = 'Europe')

/*  
    2nd WORKING TABLE : nobel
*/

--1. Show the total number of prizes awarded.
SELECT count(*)
  FROM nobel

--2. List each subject - just once
SELECT distinct(subject)
from nobel

--3. Show the total number of prizes awarded for Physics.
SELECT COUNT(*)
  FROM nobel
 WHERE subject = 'Physics'

--4. For each subject show the subject and the number of prizes.
SELECT subject, count(winner)
  FROM nobel
 GROUP BY subject

--5.For each subject show the first year that the prize was awarded.
SELECT subject, min(yr)
  FROM nobel
 GROUP BY subject

--6.For each subject show the number of prizes awarded in the year 2000.
SELECT subject, count(winner)
  FROM nobel
 WHERE yr = 2000
 GROUP BY subject

--7.Show the number of different winners for each subject. Be aware that Frederick Sanger has won the chemistry prize twice - he should only be counted once.
SELECT subject, count(distinct winner)
  FROM nobel
 GROUP BY subject

--8.For each subject show how many years have had prizes awarded.
SELECT subject, count(distinct yr)
  FROM nobel
 GROUP BY subject

--9.Show the years in which three prizes were given for Physics.
SELECT yr
  FROM nobel
 WHERE subject = 'Physics'
 GROUP BY yr 
HAVING COUNT(winner) = 3

--10.Show winners who have won more than once.
SELECT winner
  FROM nobel
 GROUP BY winner
HAVING COUNT(winner) > 1

--11.Show winners who have won more than one subject.
SELECT winner
  FROM nobel
 GROUP BY winner
HAVING COUNT(distinct subject) > 1

--12.Show the year and subject where 3 prizes were given. Show only years 2000 onwards.
SELECT yr, subject FROM nobel
 WHERE yr >= 2000
 GROUP BY yr, subject
HAVING COUNT(DISTINCT winner)=3