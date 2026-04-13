create database TrigerKalikas
Use TrigerKalikas

--tabel linnad
Create table linnad(
linnId int primary key identity(1,1),
linnaNimi varchar(50) unique,
rahvaarv int not null
);

--tabel logi
Create table logi(
Id int primary key identity(1,1),
kuupaev Datetime,
andmed TEXT
);


--kontrollimiseks tuleb li
INSERT INTO linnad(linnaNimi, rahvaarv)
Values ('test10', 60000);

select * from linnad;
SELECT * FROM logi;

--kustutame triger
Drop trigger linnaLisamine




--Insert Triger
Create TRIGGER linnaLisamine
ON linnad 
FOR INSERT
AS
INSERT INTO logi(kuupaev, andmed, kasutaja)
SELECT --values
getdate(),
CONCAT('lisatud linn: ', inserted.linnanimi, 
' | tahvaarv: ', inserted.rahvaarv, ' | id: ', inserted.linnId),
SYSTEM_USER
FROM inserted;



--DELETE TRIGGER 
Create TRIGGER linnaKustutamine
ON linnad 
FOR DELETE
AS
INSERT INTO logi(kuupaev, andmed, kasutaja)
SELECT --values
getdate(),
CONCAT('kustutatud linn: ', DELETED.linnanimi, 
' | tahvaarv: ', DELETED.rahvaarv, ' | id: ', DELETED.linnId),
SYSTEM_USER
FROM DELETED;

--SELECT ja Kustutamine
DELETe from linnad where linnId=6;

SELECT * FROM linnad;
SELECT * FROm logi;


--UPDATE TRIGGER
Create TRIGGER linnaUuendamine
ON linnad 
FOR UPDATE
AS
INSERT INTO logi(kuupaev, andmed, kasutaja)
SELECT --values
getdate(),
CONCAT('vana linna andmed: ', d.linnanimi, 
' | rahvaarv: ', d.rahvaarv, ' | id: ', d.linnId,
'uued linna andmed: ', i.linnanimi,
' | ', i.rahvaarv, ' | id: ', i.linnId),
SYSTEM_USER
FROM DELETED d INNER JOIN inserted i
ON  d.linnId=i.linnId;

--kontrollimiseks uuendame linna andmed
UPDATE linnad Set linnaNimi = 'Tapa uus', rahvaarv=25
WHERE linnId=7;

SELEct * FROM linnad
SELECT * FROM logi

--lisame kasutajaNimi logi tabelisse
ALTER table logi ADD kasutaja varchar(40);



--INSERT, DELETE Trigger
Create TRIGGER linnaLisamineKustutamine
ON linnad 
FOR INSERT, DELETE
AS
BEGIN
SET NOCOUNT ON;

	INSERT INTO logi(kuupaev, andmed, kasutaja)
	SELECT --values
	getdate(),
	CONCAT('lisatud linn: ', inserted.linnanimi, 
	' | tahvaarv: ', inserted.rahvaarv, ' | id: ', inserted.linnId),
	SYSTEM_USER
	FROM inserted

	UNION ALL

	SELECT 
	getdate(),
	CONCAT('kustutatud linn: ', deleted.linnanimi, 
	' | tahvaarv: ', deleted.rahvaarv, ' | id: ', deleted.linnId),
	SYSTEM_USER
	FROM deleted;

END;

--deaktiveerime linnalisamine ja linnakustutamine
DISABLE TRIGGER linnaLisamine on linnad;
DISABLE TRIGGER linnaKustutamine on linnad;

--kontrollimiseks tuleb li
INSERT INTO linnad(linnaNimi, rahvaarv)
Values ('test10', 60000);

select * from linnad;
SELECT * FROM logi;

DELETE FROM linnad where linnId=8





--ülisande

--tabelit loomine
CREATE TABLE Autod (
autoId int  primary key identity(1,1),
autoNumber char(6),
Omanik varchar(50),
mark varchar(50),
aasta int
);

--tabel logi
Create table Autologi(
Id int primary key identity(1,1),
kuupaev Datetime,
andmed TEXT,
kasutaja TEXT
);


--TRIGGERIT

--INSERT, DELETE Trigger
Create TRIGGER AutodLisamineKustutamine
ON Autod
FOR INSERT, DELETE
AS
BEGIN
SET NOCOUNT ON;

	INSERT INTO Autologi(kuupaev, andmed, kasutaja)
	SELECT 
	getdate(),
	CONCAT('lisatud auto: ', inserted.autoNumber, 
	' | omanik: ', inserted.Omanik,	' | mark: ', inserted.mark, ' | aasta: ', inserted.aasta,
	' | id: ', inserted.autoId),
	SYSTEM_USER
	FROM inserted

	UNION ALL

	SELECT 
	getdate(),
	CONCAT('kustutatud auto: ', deleted.autoNumber, 
	' | omanik: ', deleted.Omanik,	' | mark: ', deleted.mark, ' | aasta: ', deleted.aasta,
	' | id: ', deleted.autoId),
	SYSTEM_USER
	FROM deleted;

END;


--UPDATE TRIGGER
Create TRIGGER AutodUuendamine
ON Autod
FOR UPDATE
AS
INSERT INTO Autologi(kuupaev, andmed, kasutaja)
SELECT
getdate(),
CONCAT('vana auto andmed: ', d.autoNumber, ' | omanik: ', d.Omanik, ' | mark: ', d.mark,
' | aasta: ', d.aasta,' | id: ', d.autoId,' || uued auto andmed: ', i.autoNumber,

' | omanik: ', i.Omanik, ' | mark: ', i.mark, ' | aasta: ', i.aasta,
' | id: ', i.autoId),
SYSTEM_USER
FROM DELETED d 
INNER JOIN inserted i
ON d.autoId = i.autoId;


INSERT INTO Autod(autoNumber, Omanik, mark, aasta)
VALUES ('123ABC', 'Ivan Ivanov', 'BMW', 2020);

DELETE FROM Autod where AutoId=1

select * from Autod;
SELECT * FROM Autologi;

