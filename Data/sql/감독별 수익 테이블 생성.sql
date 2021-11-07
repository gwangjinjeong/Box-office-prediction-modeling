
#
drop view DP;
create view DP as
select c.title, c.DICD, m.total_profit
from MovieDirection as c right outer join m_1000 as m
on c.title = m.title;

select * from DP limit 1000000;

#영화제목과 수익항목을 결합한 테이블 생성
create table DirectorProfit as
select D.title, D.DICD, D.total_profit, di.`Name`
from DP as D left outer join director as di
on D.DICD=di.DICD;

select * from DirectorProfit limit 1000000;

#값 선정하기

create view DPS as
select avg(total_profit) as avgP,min(total_profit) as minP,max(total_profit) as maxP,sum(total_profit) as sumP,DICD  
from DirectorProfit group by DICD;


create table ANA_Director as
select D.avgP,D.minP,D.maxP, D.sumP, D.DICD, DI.`Name` 
from DPS as D 
left outer join director as DI 
on D.DICD=DI.DICD limit 1000000;


select * from ANA_Director;

