/*
  Joins
*/
--1.Show the matchid and player name for all goals scored by Germany.
SELECT matchid, player
  FROM goal
 WHERE teamid = 'GER'

--2.Show id, stadium, team1, team2 for just game 1012.
SELECT id, stadium, team1, team2
  FROM game
 WHERE id = 1012
 
--3.Show the player, teamid, stadium and mdate for every German goal.
SELECT player, teamid, stadium, mdate
  FROM game g
  JOIN goal gl ON gl.matchid = g.id
 WHERE gl.teamid = 'GER' 

--4.Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT g.team1, g.team2, gl.player
  FROM game g JOIN goal gl ON gl.matchid = g.id
 WHERE gl.player LIKE 'Mario%'
  
--5.Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT g.player, g.teamid, e.coach, g.gtime
  FROM goal g
  JOIN eteam e ON e.id = g.teamid
 WHERE g.gtime <= 10

--6.List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT g.mdate, e.teamname
  FROM game g 
  JOIN eteam e ON e.id = g.team1
 WHERE e.coach = 'Fernando Santos' 

--7.List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT gl.player
FROM game g
JOIN goal gl ON gl.matchid = g.id
WHERE g.stadium = 'National Stadium, Warsaw'

--8.Show the name of all players who scored a goal against Germany.
SELECT DISTINCT(player)
  FROM game
  JOIN goal ON goal.matchid = game.id
 WHERE (teamid <> 'GER' AND team1 = 'GER')
    OR (teamid <> 'GER' AND team2 = 'GER')

--9.Show teamname and the total number of goals scored.
SELECT teamname, COUNT(player)
  FROM goal
  JOIN eteam ON eteam.id = goal.teamid
 GROUP BY teamname;

--10. Show the stadium and the number of goals scored in each stadium.
SELECT stadium, count(player)
  FROM game 
  JOIN goal ON goal.matchid = game.id
 GROUP BY stadium;

--11.For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid, mdate, count(player) As Score
  FROM game 
  JOIN goal ON goal.matchid = game.id
 WHERE team1 = 'POL' OR team2 = 'POL'
 GROUP BY matchid, mdate

--12.For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT gl.matchid, g.mdate, COUNT(gl.player)
  FROM game g
  JOIN goal gl ON gl.mathchid = g.id
 WHERE team1 = 'GER' OR team2 = 'GER'
 GROUP BY gl.matchid, g.mdate

--13. List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
SELECT mdate, team1,
       SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) score1,
       team2,
       SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
  FROM game
  LEFT JOIN goal ON game.id = goal.matchid
 GROUP BY id, team1, team2, mdate
 ORDER BY mdate, team1, team2, id

--14.Write the code which shows players, their team and the amount of goals they scored against Greece(GRE).
SELECT player, teamid, COUNT(*)
  FROM game JOIN goal WITH matchid = id
 WHERE (team1 = "GRE" OR team2 = "GRE")
   AND teamid != 'GRE'
 GROUP BY player, teamid

 --15.Write the code which would show the player and their team for those who have scored against Poland(POL) in National Stadium, Warsaw.
 SELECT DISTINCT player, teamid 
   FROM game JOIN goal ON matchid = id 
  WHERE stadium = 'National Stadium, Warsaw' 
    AND (team1 = 'POL' OR team2 = 'POL')
    AND teamid != 'POL'

--16.Select the code which shows the player, their team and the time they scored, for players who have played in Stadion Miejski (Wroclaw) but not against Italy(ITA).
SELECT DISTINCT player, teamid, gtime
  FROM game JOIN goal ON matchid = id
 WHERE stadium = 'Stadion Miejski (Wroclaw)'
   AND (( teamid = team2 AND team1 != 'ITA') OR ( teamid = team1 AND team2 != 'ITA'))

/*
  Table Working: Teacher
*/

--1.shows the name of department which employs Cutflower.
 SELECT dept.name 
   FROM teacher 
   JOIN dept ON (dept.id = teacher.dept) 
  WHERE teacher.name = 'Cutflower'

--2.show a list of all the departments and number of employed teachers.
 SELECT dept.name, COUNT(teacher.name) 
   FROM teacher 
  RIGHT JOIN dept ON dept.id = teacher.dept 
  GROUP BY dept.name

--3.show name, a new column called Category, if dept are 1 , 2 then 'Sci', and 'art' if dept is 3  ,else 'Other'.
 SELECT name, 
      CASE 
       WHEN dept IN (1,2) THEN 'Computing' 
       WHEN dept = 3 THEN 'Art'
       ELSE 'Other' 
      END AS Category
  FROM teacher

/*
  Using Null and CASE WHEN in SQL.
  Table working: Teacher
*/

--1.List the teachers who have NULL for their department.
SELECT name 
  FROM teacher
 WHERE dept IS NULL

--2.Use a different JOIN so that all teachers are listed.
SELECT teacher.name, dept.name AS department
  FROM teacher 
  LEFT JOIN dept ON dept.id = teacher.dept 

--3.Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given. Show teacher name and mobile number or '07986 444 2266'
SELECT name, COALESCE(mobile,'07986 444 2266')
FROM teacher

--4.Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. Use the string 'None' where there is no department.
SELECT t.name, COALESCE(d.name, 'None')
  FROM teacher t
  LEFT JOIN dept d ON d.id = t.dept

--5.Use COUNT to show the number of teachers and the number of mobile phones.
SELECT COUNT(name) AS teacher_num, COUNT(mobile) AS mobile_num
FROM teacher

--6.Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed.
SELECT d.name, COUNT(t.name)
  FROM teacher t
 RIGHT JOIN dept d ON d.id = t.dept
 GROUP BY d.name

--7.Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.
SELECT name,
       CASE WHEN dept IN (1,2) THEN 'Sci'
            ELSE 'Art' END AS Dept_descript
FROM teacher

--8.use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise.
SELECT name,
       CASE WHEN dept IN (1,2) THEN 'Sci'
            WHEN dept = 3 THEN 'Art' 
            ELSE 'None'
            END AS Dept_descript
FROM teacher