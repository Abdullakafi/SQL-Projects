USE master
go
DROP database IF EXISTS bookrepositorydb
go
create database bookrepositorydb
go
USE bookrepositorydb
go
create table Authors
(
	authorId nvarchar(10) NOT NULL primary key,
	authorname nvarchar(30) NOT NULL
)
go
create table Topics
(
	topicId nvarchar(10) NOT NULL primary key,
	topicName nvarchar(30) NOT NULL
)
go
create table Publishers
(
	publisherid nvarchar (10) NOT NULL primary key,
	publisherName nvarchar(30) NOT NULL
)
go
create table Books
(
	bookID nvarchar(10) NOT NULL primary key,
	bookName nvarchar(30) NOT NULL,
	publisherid	nvarchar(10) NOT NULL references Publishers(publisherid)
)

go
create table AuthorBooks
(
	authorId nvarchar(10) NOT NULL references Authors(authorId),
	bookID nvarchar(10) NOT NULL references  Books(bookID),
	primary key (authorId,bookID)
)

create table BookTopics(
	bookID nvarchar(10) NOT NULL references  Books(bookID),
	topicId nvarchar(10) NOT NULL references  Topics(topicId),
	primary key (bookID,topicId)
)
go
--1st create PROCEDURE Insert Data Autor Table

create PROC spInsertAuthor @spAuthorId nvarchar(10),
						  @spAuthorName nvarchar(30)
AS
begin TRY
	insert INTO Authors(authorId, authorname) VALUES(@spAuthorId, @spAuthorName)
end TRY 
begin catch
	declare @Message nvarchar(1000)
	select @Message = ERROR_MESSAGE()
	;
	THROW 50001 , @Message, 1
end catch
go
--Update Procedure Authors Table

create PROC spUpdateAuthor @spAuthorId nvarchar(10),
						  @spAuthorName nvarchar(30)
AS
begin TRY
	update Authors 
	SET authorId = @spAuthorId, authorname = @spAuthorName
	where authorId = @spAuthorId
end TRY 
begin catch
	;
	THROW 50002, 'Update Failed' , 1
end catch
go

-- Delete Procedure Authors Table

create PROC spDeleteAuthor @spAuthorId nvarchar(10)
AS
begin TRY
	DELETE Authors 
	where authorId = @spAuthorId
end TRY 
begin catch
	;
	THROW 50002, 'Cannont Delete' , 1
end catch
go

-- 2nd Insert, Update and Delete Data Publishers Table

create PROC spInsertPublishers @spPid nvarchar(10),
						  @spPname nvarchar(30)
AS
begin TRY
	INSERT INTO Publishers(publisherid, publisherName) VALUES(@spPid, @spPname)
END TRY 
begin catch
	declare @Message nvarchar(1000)
	select @Message = ERROR_MESSAGE()
	;
	THROW 50001 , @Message, 1
end catch
go

--Update

create PROC spUpdatePublishers @spPid nvarchar(10),
							@spPname nvarchar(30)
AS
begin TRY 
	update Publishers 
	SET publisherid = @spPid , publisherName =@spPname
	where publisherid = @spPid
end TRY 
begin catch
	;
	THROW 50001, 'Update Failed' , 1
end catch
go

--Delete

create PROC spDeletePublishers @spPid nvarchar(10)
AS
begin TRY
		DELETE Publishers
		where publisherid = @spPid
end TRY
begin catch
	;
	THROW 50001, ' Cannot delete ', 1
end catch
go

-- 3rd Insert, Update and Delete Data Topics Table
--Insert

create PROC spInsertTopics @spTid nvarchar(10),
						  @spTname nvarchar(30)
AS
begin TRY
	insert INTO Topics(topicId,topicName) VALUES(@spTid, @spTname)
end TRY 
begin catch
	declare @Message nvarchar(1000)
	SELECT @Message = ERROR_MESSAGE()
	;
	THROW 50001 , @Message, 1
end catch
go

----Update

create PROC spUpdateTopics @spTid nvarchar(10),
						  @spTname nvarchar(30)
AS
begin TRY
	update Topics
	SET topicId = @spTid , topicName =@spTname
	where topicId = @spTid
end TRY 
begin catch
	;
	THROW 50001 , 'Update Failed', 1
end catch
go

----Delete

create PROC spDelteTopics @spTid nvarchar(10)
AS
begin TRY
	DELETE Topics
	where topicId = @spTid
end TRY 
begin catch
	;
	THROW 50001 , 'Update Failed', 1
end catch
go

-- 4th Insert, Update and Delete Data Books Table
--Insert

create PROC spInsertBooks @spBid nvarchar(10),
						  @spBname nvarchar(30),
						  @spPid nvarchar(10)
AS
begin TRY
	insert INTO Books(bookID, bookName, publisherid) VALUES(@spBid, @spBname,@spPid )
end TRY 
begin catch
	declare @Message nvarchar(1000)
	select @Message = ERROR_MESSAGE()
	;
	THROW 50001 , @Message, 1
end catch
go

--Update

create PROC spUpdateBooks @spBid nvarchar(10),
						  @spBname nvarchar(30),
						  @spPid nvarchar(10)
AS
begin TRY
	update Books
	SET  bookName = @spBname,  publisherid = @spPid
	where bookID = @spBid
end TRY 
begin catch
	declare @Message nvarchar(1000)
	select @Message = ERROR_MESSAGE()
	;
	THROW 50001 , @Message, 1
end catch
go

--Delete

create PROC spDeleteBooks @spBid nvarchar(10)
AS
begin TRY
	DELETE Books
	where bookID = @spBid
end TRY 
begin catch
	declare @Message nvarchar(1000)
	select @Message = ERROR_MESSAGE()
	;
	THROW 50001 , 'Dont Delete', 1
end catch
go

-- 5th Insert, Update and Delete Data AuthorBook Table
--Insert

create PROC spInsertAuthorBooks @spAid nvarchar(10),
								@spBid nvarchar(10)
AS
begin TRY
	insert INTO AuthorBooks (authorId, bookID) VALUES (@spAid,@spBid)
end TRY
begin catch
	declare @msg nvarchar(1000)
	select @msg = ERROR_MESSAGE()
	;
	THROW 50001, @msg, 1
end catch 
go

--UPDATE 
create PROC spUpdateAuthorBooks @spAid nvarchar(10),
								@spBid nvarchar(10)
AS
begin TRY
	update AuthorBooks 
	SET authorId = @spAid,bookID = @spBid 
end TRY
begin catch
	;
	THROW 50001, 'Dont Update', 1
end catch 
go
-- 6th Insert, Update and Delete Data BookTopics Table
--Insert
create PROC spInsertBookTopics @spBid nvarchar(10),
								@sTBid nvarchar(10)
AS
begin TRY
	insert INTO BookTopics(bookID, topicId) VALUES (@spBid,@sTBid)
end TRY
begin catch
	declare @msg nvarchar(1000)
	select @msg = ERROR_MESSAGE()
	;
	THROW 50001, @msg, 1
end catch 
go
--UPDATE 
create PROC spUpdateBookTopics @spBid nvarchar(10),
								@sTBid nvarchar(10)
AS
begin TRY
	update BookTopics
	SET bookID = @spBid,  topicId = @sTBid
	where bookID = @spBid
end TRY
begin catch
	;
	THROW 50001, 'Dont Update', 1
end catch 
go

create NONCLUSTERED INDEX ixBookName 
on Books (bookName)
go

--  Create Function: a. scalar function
--Insert	
go
create FUNCTION fnScalar(@publisherid nvarchar(10) ) returns nvarchar(10)
AS
begin
	declare @n nvarchar(10) 
	select @n = COUNT(*) from books
	where @publisherid =@publisherid
	return @n
end
go
--SELECT dbo.fnScalar 
create FUNCTION fnAuthor(@authorid nvarchar(10)) returns nvarchar(10)
AS
begin
declare @i nvarchar(10)
select @i = COUNT(*) from AuthorBooks
where authorId= @authorid
return @i
end
go
--b. A table valued function
create FUNCTION fnTable(@publisherid nvarchar(10)) returns TABLE
AS
return
(
select b.bookid, bookname, a.authorname, b.publisherid
from Books b
INNER JOIN AuthorBooks ab
on ab.bookid = b.bookid
INNER JOIN Authors a
on ab.authorid = a.authorid
where publisherid =@publisherid
)
go
--View 
create VIEW vInfo
AS
select b.bookid, bookname, a.authorname, b.publisherid
from books b
INNER JOIN AuthorBooks ab
on ab.bookid = b.bookid
INNER JOIN Authors a
on ab.authorid = a.authorid
go
--TRIGGER
create trigger trauthorbooks
on AuthorBooks 
AFTER insert 
AS 
	begin
		declare @t_id nvarchar(10)
		select @t_id = authorid from inserted
	end
	begin
		IF exists
		(
			select count(*), authorId from AuthorBooks
			where authorId =@t_id
			GROUP BY authorid
			having COUNT(*) >3
	
		)
			ROLLBACK TRANSACTION
			; 
			THROW 50001,'Author already have three books',1
		end 

