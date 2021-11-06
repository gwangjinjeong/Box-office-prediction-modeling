
use capmov;

#테이블을 만들지 않고 뷰를 만드는 이유는 조회시 일회성으로 생성되기 때문에 뷰를 이용했습니다.
DROP view IF EXISTS DirectorResult;
create view DirectorResult as
select C.title, C.DICD, D.`Name` 
from MovieDirection as C 
left outer join director as D
on C.DICD = D.DICD where `Name`= '홍상수'; 

#장르 테이블에 배우의 출연영화를 조인한 뷰를 조인함으로써 결과값을 얻었습니다.
DROP view IF EXISTS DirectorGenre;
Create view DirectorGenre as
select D.DICD, D.`Name`,G.genre,G.title
from DirectorResult as D
inner join  genre as G
on G.title=D.title;



select genre,count(genre) from DirectorGenre group by genre;
