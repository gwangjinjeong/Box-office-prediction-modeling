


#감독의 출연영화의 수입 산출하기
#케스트 테이블과 엑터 테이블을 이용해 감독의 연출영화를 출력, 뷰를 만든 후 영화 테이블을 조인 함으로써 결과 값을 얻을 수 있습니다.

#테이블을 만들지 않고 뷰를 만드는 이유는 조회시 일회성으로 생성되기 때문에 뷰를 이용했습니다.
drop view  DirectorTimeline;
create view DirectorTimeline as
select C.title, C.DICD, D.`Name` 
from MovieDirection as C 
left outer join Director as D
on C.DICD = D.DICD where `Name`= '홍상수'; 

select * from DirectorTimeline;

#만들어진 뷰에 영화 테이블을 조인하고, 개봉일 순으로 배열을 함으로써, 감독이 연출한 영화의 수익을 시간의 흐름에 따라 파악할 수 있습니다.
drop view DirectorTimelineResult;
create view DirectorTimelineResult as
select D.title,D.DICD,D.`Name`,M.total_profit, M.open_date 
from DirectorTimeline as D
left outer join m_1000 as M 
on D.title=M.title order by open_date;

select * from DirectorTimelineResult where open_date !="";