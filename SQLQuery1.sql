create table Authors(
	AuthorId int primary key identity (1,1),
	AuthorName nvarchar(100),
	AuthorSurname nvarchar(100)
)

insert into Authors
values ('Agata','Cristi'),('JUL','Vern'),('Herbert','Uells')

create table Books(
	BookId int primary key identity (1,1),
	BookName nvarchar(50),
	AuthorId int,
	BookPageCount int check (BookPageCount >= 10), 
	foreign key (AuthorId) references Authors(AuthorId)
)

insert into Books
values ('Mavi qatarin sirri',1,450),
('Kapitan Qrantin usaqlari',2,850),
('Zaman masini',3,520)

create view BookAuthorInfo as
select 
		BookId,
		BookName,
		BookPageCount,
		CONCAT(a.AuthorName, ' ', a.AuthorSurname) AS AuthorFullName
from Books
JOIN Authors a ON Books.AuthorId = a.AuthorId
		

alter procedure usp_SearchBooks @searchItem int
As
	select 
		BookId,
		BookName,
		BookPageCount,
		CONCAT(a.AuthorName, ' ', a.AuthorSurname) AS AuthorFullName
	from Books
JOIN Authors a ON Books.AuthorId = a.AuthorId
WHERE BookName LIKE CONCAT('%', @searchItem, '%')



create procedure usp_InsertAuthor @name nvarchar(50), @surname nvarchar(50)
as
begin
    INSERT INTO Authors 
    VALUES (@name, @surname)
end

create procedure usp_UpdateAuthor @UpdateId int, @name nvarchar(50), @surname nvarchar(50)
as
begin
	update Authors set AuthorName=@name,AuthorSurname=@surname
	where AuthorId = @UpdateId
end


create procedure DeleteAuthor @DeleteId int 
as
begin
delete from Authors 
where AuthorId = @DeleteId
end


create view AuthorAll AS
SELECT 
    a.AuthorId,
    CONCAT(a.AuthorName, ' ', a.AuthorSurname) AS FullName,
    COUNT(BookId) AS BooksCount,          
    MAX(BookPageCount) AS MaxPageCount    
FROM Authors a
JOIN Books  
ON a.AuthorId = Books.AuthorId
GROUP BY a.AuthorId, a.AuthorName, a.AuthorSurname





select * from Authors
select * from Books
select * from BookAuthorInfo
EXEC usp_SearchBooks @searchItem = 2
select * from AuthorAll