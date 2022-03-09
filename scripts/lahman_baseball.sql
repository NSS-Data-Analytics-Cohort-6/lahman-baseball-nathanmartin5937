/*What range of years for baseball games played does the provided database cover?
1871-2016

select yearid, name
from teams 
order by yearid; */

/*Find the name and height of the shortest player in the database. How many games did he play in? What is the name of the team for which he played?
SLA, 1951, 154, Edward Carl, 43

select a.teamid, a.yearid, t.g, p.namegiven, p.height
from appearances as a
inner join people as p
on p.playerid = a.playerid
inner join teams as t
on a.teamid = t.teamid and a.yearid = t.yearid
where a.playerid =  
	(select playerid 
	from people 
	order by height
	limit 1);*/
	
/*Find all players in the database who played at Vanderbilt University. 
Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. 
Sort this list in descending order by the total salary earned. 
Which Vanderbilt player earned the most money in the majors?
David Price

select c.schoolid, p.namefirst, p.namelast, SUM(z.salary) as salary_total
from people as p
inner join salaries as z
on p.playerid = z.playerid
inner join collegeplaying as c
on p.playerid = c.playerid
where c.schoolid = 
	(select s.schoolid
	from schools as s
	where s.schoolname = 'Vanderbilt University')
group by p.playerid, c.schoolid
order by salary_total DESC
limit 1; */


