

#수익 항목을 연출항목에 추가
drop view AP;
create view AP as
select c.title, c.actorCD, m.total_profit
from MovieCast as c right outer join m_1000 as m
on c.title = m.title;

select * from AP limit 1000000;

#영화제목과 수익항목을 결합한 테이블 생성
create table ActorProfit as
select A.title, A.actorCD, A.total_profit, AA.`Name`
from AP as A left outer join actor as AA
on D.acotrCD=di.actorCD;

select * from ActorProfit limit 1000000;

#값 선정하기

drop view APS;
create view APS as
select avg(total_profit) as avgP,min(total_profit) as minP,max(total_profit) as maxP,sum(total_profit) as sumP,actorCD  
from ActorProfit group by actorCD;

create table ANA_Actor as
select A.avgP,A.minP,A.maxP, A.sumP, A.actorCD, AA.`Name` 
from APS as A 
left outer join actor as AA 
on A.actorCD=AA.actorCD limit 1000000;

select * from ANA_Actor;


