/* What range of years for baseball games played does the provided database cover?
1871-2016

select yearid, name
from teams */

select namegiven, height, t.teamid
from people as p
inner join teams as t
on p.code = t.code;