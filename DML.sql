USE bookrepositorydb
GO
--1st Insert, Update , Delete Data Author Table

exec spInsertAuthor 'A101', 'zosim'
go
exec spInsertAuthor 'A102', 'abdulla'
go
exec spInsertAuthor 'A103', 'baki'
go
exec spInsertAuthor 'A106', 'kafi'
go
exec spInsertAuthor 'A104', 'Mahmud'
go
exec spInsertAuthor 'A105', 'rakib'
go
select * from Authors 

----Update Data From news Table Using PROCEDURE

exec spUpdateAuthor 'A104', 'kamal'
go

----Delete Data From news Table Using PROCEDURE--

exec spDeleteAuthor 'A105'
go
select * from Authors
go


--2nd Insert, Update , Delete Data Publishers Table--

exec spInsertPublishers 'P101', 'ANUPAM '
go
exec spInsertPublishers 'P102', 'SHIKHA '
go
exec spInsertPublishers 'P103', 'SHOVA '
go
exec spInsertPublishers 'P104', 'SHUCHIPOTRO'
go
exec spInsertPublishers 'P105', 'SHUDDASHAR'
go
exec spInsertPublishers 'P106', ' PUBLICATIONS'
go
exec spInsertPublishers 'P107', 'BIDDYAPROKASH'
go
exec spInsertPublishers 'P108', 'ANUPAM '
go
exec spInsertPublishers 'P109', 'ANUPAM '
go
exec spInsertPublishers 'P110', 'ANUPAM '
go

--Update

exec spUpdatePublishers @spPid='P110', @spPname = 'GYANKOSH '
go
select * from Publishers
go

--DELETE

exec spDeletePublishers 'P109'
go
select * from Publishers
go

-- 3rd Insert, Update , Delete Data Topics Table

exec spInsertTopics 'T101', ' prothom alo.'
go
exec spInsertTopics 'T102', ' daily star.'
go
exec spInsertTopics 'T103', 'bd news.'
go
exec spInsertTopics 'T104', ' bangladesh every day.'
go
exec spInsertTopics 'T105', 'daily star.'
go
exec spInsertTopics 'T106', ' juganto .'
go
exec spInsertTopics 'T107', ' prothom alo.'
go
exec spInsertTopics 'T108', 'juganto.'
go

--update

exec spUpdateTopics 'T107', 'bd protidin'
go
select * from Topics
go

--delete

exec spDelteTopics 'T108' 
go
select * from Topics
go

-- 4th Insert, Update , Delete Data Books Table
--insert

exec spInsertBooks 'B101', 'Java', 'P101'
exec spInsertBooks 'B102', 'Rubi', 'P101'
exec spInsertBooks 'B103', 'C#', 'P102'
exec spInsertBooks 'B104', 'Python', 'P103'
exec spInsertBooks 'B105', 'C++', 'P104'
exec spInsertBooks 'B106', 'C', 'P105'
exec spInsertBooks 'B107', 'SQL', 'P105'
exec spInsertBooks 'B108', 'MVC', 'P106'
go

--update

exec spUpdateBooks 'B108', 'ASP.NET', 'P105'
go
select * from Books
go

--delete

exec spDeleteBooks 'B108'
go
select * from Books
go

--5th Insert, Update , Delete Data AuthorBooks Table
exec spInsertAuthorBooks 'A101', 'B101'
exec spInsertAuthorBooks 'A101', 'B102'
exec spInsertAuthorBooks 'A102', 'B103'
exec spInsertAuthorBooks  'A103', 'B101'
exec spInsertAuthorBooks 'A104', 'B104'
exec spInsertAuthorBooks 'A104', 'B102'
exec spInsertAuthorBooks 'A105', 'B104'
exec spInsertAuthorBooks 'A105', 'B105'
go
---- JOIN All Table------

go
select * from
Authors a 
inner JOIN AuthorBooks ab on ab.authorId = a.authorId
inner JOIN Books b on b.bookID  = ab.bookID
inner JOIN Publishers p on b.publisherid = p.publisherid
inner JOIN BookTopics bt on b.bookID = bt.bookID
inner JOIN Topics t on bt.topicId = t.topicId
go


select * from vInfo
go
--function
SELECT dbo.fnAuthor('P101')
go
select * from fnTable ('P101')
go
--trigger
exec spInsertAuthorBooks 'A105', 'B102'
go
/*
 * Queries Added
 *
 * */
--1 INNER JOIN
select        p.publisherName, b.bookName, t.topicName, a.authorname
from            Publishers p
inner join
                         Books b on p.publisherid = b.publisherid 
inner join
                         AuthorBooks ab on b.bookID = ab.bookID 
inner join
                         Authors a on ab.authorId = a.authorId 
inner join
                         BookTopics bt on b.bookID = bt.bookID 
inner join
                         Topics t on bt.topicId = t.topicId
go
--2 INNER JOIN FILTER
select        p.publisherName, b.bookName, t.topicName, a.authorname
from            Publishers p
inner join
                         Books b on p.publisherid = b.publisherid 
inner join
                         AuthorBooks ab on b.bookID = ab.bookID 
inner join
                         Authors a on ab.authorId = a.authorId 
inner join
                         BookTopics bt on b.bookID = bt.bookID 
inner join
                         Topics t on bt.topicId = t.topicId
WHERE p.publishername = 'SHIKHA PROKASHONI'
go
--3 INNER JOIN FILTER
select        p.publisherName, b.bookName, t.topicName, a.authorname
from            Publishers p
inner join
                         Books b ON p.publisherid = b.publisherid 
inner join
                         AuthorBooks ab on b.bookID = ab.bookID 
inner join
                         Authors a on ab.authorId = a.authorId 
inner join
                         BookTopics bt on b.bookID = bt.bookID 
inner join
                         Topics t on bt.topicId = t.topicId
WHERE t.topicName = '.NET Framework'
go
-- 4 RIGHT OUTER
select        p.publisherName, b.bookName, t.topicName, a.authorname
from            AuthorBooks as ab 
inner join
                         Books as b on ab.bookID = b.bookID 
inner join
                         Authors as a on ab.authorId = a.authorId 
inner join
                         BookTopics as bt on b.bookID = bt.bookID 
right outer join
                         Topics as t ON bt.topicId = t.topicId 
right outer join
                         Publishers as p on b.publisherid = p.publisherid

go
-- 5 change 4 to CTE
WITH summury as
(
select        b.publisherid, b.bookName, a.authorname, bt.topicId
from            AuthorBooks as ab 
inner join
                         Books as b on ab.bookID = b.bookID 
inner join
                         Authors as a on ab.authorId = a.authorId 
inner join
                         BookTopics as bt on b.bookID = bt.bookID 
)
select p.publisherName, s.bookName, t.topicName, s.authorname
from summury as s
right outer join
                         Topics as t on s.topicId = t.topicId 
right outer join
                         Publishers as p on s.publisherid = p.publisherid

go
-- 6 RIGHT OUTER NOT MATCHING
select        p.publisherName, b.bookName, t.topicName, a.authorname
from            AuthorBooks as ab 
inner join
                         Books as b on ab.bookID = b.bookID 
inner join
                         Authors as a on ab.authorId = a.authorId 
inner join
                         BookTopics as bt on b.bookID = bt.bookID 
right outer join
                         Topics as t on bt.topicId = t.topicId 
right outer join
                         Publishers as p on b.publisherid = p.publisherid
WHERE b.bookID IS NULL
go
-- 7 RIGHT OUTER NOT MATCHING SUB QUERY
select        p.publisherName, b.bookName, t.topicName, a.authorname
from            AuthorBooks as ab 
inner join
                         Books as b on ab.bookID = b.bookID 
inner join
                         Authors as a on ab.authorId = a.authorId 
inner join
                         BookTopics as bt on b.bookID = bt.bookID 
right outer join
                         Topics as t on bt.topicId = t.topicId 
right outer join
                         Publishers as p on b.publisherid = p.publisherid
WHERE NOT (b.bookID IS NOT NULL AND b.bookID IN (SELECT bookID FROM Books))
go
--8 AGGREGATE
select        p.publisherName, t.topicName, a.authorname, COUNT(b.bookid)
from            AuthorBooks as ab 
inner join
                         Books as b on ab.bookID = b.bookID 
inner join
                         Authors as a on ab.authorId = a.authorId 
inner join
                         BookTopics as bt on b.bookID = bt.bookID 
right outer join
                         Topics as t on bt.topicId = t.topicId 
right outer join
                         Publishers as p on b.publisherid = p.publisherid
GROUP BY p.publisherName, t.topicName, a.authorname
go
--9 AGGREGATE AND HAVING
select        p.publisherName, t.topicName, a.authorname, COUNT(b.bookid)
from            AuthorBooks as ab 
inner join
                         Books as b on ab.bookID = b.bookID 
inner join
                         Authors as a on ab.authorId = a.authorId 
inner join
                         BookTopics as bt on b.bookID = bt.bookID 
right outer join
                         Topics as t on bt.topicId = t.topicId 
right outer join
                         Publishers as p on b.publisherid = p.publisherid
GROUP BY p.publisherName, t.topicName, a.authorname
HAVING a.authorname = 'Hasan'
go
--10 WINDOW
select        p.publisherName, t.topicName, a.authorname, 
COUNT(b.bookid) over (order by p.publisherName, t.topicName, a.authorname) 'count',
ROW_NUMBER() over (order by p.publisherName, t.topicName, a.authorname) 'num',
RANK() over (order by p.publisherName, t.topicName, a.authorname) 'rank',
DENSE_RANK() over (order by p.publisherName, t.topicName, a.authorname) 'denserank',
NTILE(3) over (order by p.publisherName, t.topicName, a.authorname) 'ntile'
from            AuthorBooks as ab 
inner join
                         Books as b on ab.bookID = b.bookID 
inner join
                         Authors as a on ab.authorId = a.authorId 
inner join
                         BookTopics as bt on b.bookID = bt.bookID 
right outer join
                         Topics as t on bt.topicId = t.topicId 
right outer join
                         Publishers as p on b.publisherid = p.publisherid
go
--11 CASE
select        p.publisherName, t.topicName, a.authorname, 
CASE 
WHEN COUNT(b.bookid) <=0 THEN 'No book'
ELSE CAST(COUNT(b.bookid) as VARCHAR) 
END as 'count'

from            AuthorBooks as ab 
inner join
                         Books as b on ab.bookID = b.bookID 
inner join
                         Authors as a on ab.authorId = a.authorId 
inner join
                         BookTopics as bt on b.bookID = bt.bookID 
right outer join
                         Topics as t ON bt.topicId = t.topicId 
right outer join
                         Publishers as p on b.publisherid = p.publisherid
GROUP BY p.publisherName, t.topicName, a.authorname
go
