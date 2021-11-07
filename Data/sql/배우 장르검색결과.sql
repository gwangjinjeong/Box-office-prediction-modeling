
#테이블을 만들지 않고 뷰를 만드는 이유는 조회시 일회성으로 생성되기 때문에 뷰를 이용했습니다.
DROP view IF EXISTS ActorResult;
create view ActorResult as
select C.title, C.actorCD, A.`Name` 
from MovieCast as C 
left outer join actor as A
on C.actorCD = A.actorCD where `Name`= '송강호'; 

#장르 테이블에 배우의 출연영화를 조인한 뷰를 조인함으로써 결과값을 얻었습니다.
DROP view IF EXISTS ActorGenre;
Create view ActorGenre as
select A.actorCD, A.`Name`,G.genre,G.title
from ActorResult as A
inner join  genre as G
on G.title=A.title;

select genre,count(genre) from ActorGenre group by genre;
