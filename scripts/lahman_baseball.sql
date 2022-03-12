/*What range of years for baseball games played does the provided database cover?
1871-2016*/

select yearid, name
from teams 
order by yearid; 

/*Find the name and height of the shortest player in the database. How many games did he play in? What is the name of the team for which he played?
SLA, 1951, 154, Edward Carl, 43*/

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
	limit 1);
	
/*Find all players in the database who played at Vanderbilt University. 
Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. 
Sort this list in descending order by the total salary earned. 
Which Vanderbilt player earned the most money in the majors?
David Price*/

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
limit 1; 

/*Using the fielding table, group players into three groups based on their position: label players with 
position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", 
and those with position "P" or "C" as "Battery". Determine the number of putouts made by each of these three groups in 2016.*/

select SUM(po), 
	case when pos = 'of' then 'outfield'
		 when pos = 'ss' or pos = '1b' or pos = '2b' or pos = '3b' then 'infield'
		 when pos = 'p' or pos = 'c' then 'battery'
		 end as position
from fielding 
where yearid = 2016
group by position;      /*credit Lulia*/

/*Find the average number of strikeouts per game by decade since 1920. 
Round the numbers you report to 2 decimal places. Do the same for home runs per game. 
Do you see any trends?*/

select
	SUM(g) as games,
	AVG(so + soa) as strikeouts,
	ROUND((AVG(so + soa)) / (SUM(g)), 2) as strikeouts_per_game,
	
case when yearid between 1920 and 1929 then '1920'
	 when yearid between 1930 and 1939 then '1930'
	 when yearid between 1940 and 1949 then '1940'
	 when yearid between 1950 and 1959 then '1950'
	 when yearid between 1960 and 1969 then '1960'
	 when yearid between 1970 and 1979 then '1970'
	 when yearid between 1980 and 1989 then '1980'
	 when yearid between 1990 and 1999 then '1990'
	 when yearid between 2000 and 2009 then '2000'
	 when yearid between 2010 and 2019 then '2010' 
	 end as decade

from teams
where yearid >= '1920'
group by decade
order by decade DESC;

select
	SUM(g) as games,
	AVG(hr + hra) as homeruns,
	ROUND((AVG(hr + hra)) / (SUM(g)), 2) as homeruns_per_game,
	
case when yearid between 1920 and 1929 then '1920'
	 when yearid between 1930 and 1939 then '1930'
	 when yearid between 1940 and 1949 then '1940'
	 when yearid between 1950 and 1959 then '1950'
	 when yearid between 1960 and 1969 then '1960'
	 when yearid between 1970 and 1979 then '1970'
	 when yearid between 1980 and 1989 then '1980'
	 when yearid between 1990 and 1999 then '1990'
	 when yearid between 2000 and 2009 then '2000'
	 when yearid between 2010 and 2019 then '2010' 
	 end as decade

from teams
where yearid >= '1920'
group by decade
order by decade DESC;

/*Find the player who had the most success stealing bases in 2016, where success is measured as 
the percentage of stolen base attempts which are successful. 
(A stolen base attempt results either in a stolen base or being caught stealing.) Consider 
only players who attempted at least 20 stolen bases.
owingch01, 91.30434782608695652200*/

select ((CAST(sb as numeric)/(sb+cs))*100) as stolen_base_attempts, playerid
from batting
where yearid = '2016' and sb+cs > 19
order by stolen_base_attempts desc;

/*From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? 
What is the smallest number of wins for a team that did win the world series? Doing this will probably 
result in an unusually small number of wins for a world series champion – determine why this is the case. 
Then redo your query, excluding the problem year. How often from 1970 – 2016 was it the case that a team with 
the most wins also won the world series? What percentage of the time?
1. SEA, 116 2. LAN, 63 3. */

select MAX(w) as wins, teamid
from teams
where wswin = 'N' and yearid between '1970' and '2016'
group by yearid, teamid
order by wins desc;

select MIN(w) as wins, teamid
from teams
where wswin = 'Y' and yearid between '1970' and '2016'
group by yearid, teamid
order by wins;

select MAX(w) as max_wins, teamid, yearid, wswin
from teams
where yearid between '1970' and '2016'
group by teamid, yearid, wswin
order by yearid, max_wins desc;
















