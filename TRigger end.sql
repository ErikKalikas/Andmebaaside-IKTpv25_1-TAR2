CREATE database Koolitoit
Use koolitoit

--table Toidud
CREATE TABLE Toidud(
    Id INT PRIMARY KEY IDENTITY(1,1),
    nimetus VARCHAR(50),
    hind INT,
    kokkID INT,
    FOREIGN KEY (kokkID) REFERENCES kokk(kokkID)
);

select * from Toidud

	--table Logi
	CREATE TABLE Logi (
    logiID int PRIMARY KEY IDENTITY(1,1),
    kuupaev datetime,
    andmed text,
    kasutaja varchar(100) DEFAULT USER_NAME()
);

select * from Logi

--kokk
CREATE TABLE kokk (
    kokkID INT PRIMARY KEY IDENTITY(1,1),
    kokkNimi VARCHAR(50)
 );
      
Select * from kokk
       
--Toidud INSET TRIGGER 
Create TRIGGER LisaToit
ON Toidud
FOR INSERT
AS
INSERT INTO logi(kuupaev, andmed, kasutaja)
SELECT 
getdate(),
CONCAT('roa nimi on: ', inserted.nimetus, 
' | hind on: ', inserted.hind, ' | id: ', inserted.Id),
SYSTEM_USER
FROM inserted;


--Toidud DELETE TRIGGER
CREATE TRIGGER KasutaToit
ON Toidud
FOR DELETE
AS
INSERT INTO Logi(kuupaev, andmed, kasutaja)
SELECT
GETDATE(),
CONCAT('kustutatud roa nimi on: ', deleted.nimetus,
' | hind on: ', deleted.hind,' | id: ', deleted.Id),
SYSTEM_USER
FROM deleted;


--Toidud UPDATE TRIGGER
CREATE TRIGGER UuendaToit
ON Toidud
FOR UPDATE
AS
INSERT INTO Logi(kuupaev, andmed, kasutaja)
SELECT
    GETDATE(),
    CONCAT('vana roa andmed: ',deleted.nimetus, ', ',
deleted.hind, ', id=', deleted.Id,' || uued roa andmed: ',
inserted.nimetus, ', ',inserted.hind, ', id=', inserted.Id),
	SYSTEM_USER
	FROM deleted
	INNER JOIN inserted
	ON deleted.Id = inserted.Id;

drop trigger  UuendaToit

----------------------

--kokk INSET TRIGGER 
CREATE TRIGGER LisaKokk
ON kokk
FOR INSERT
AS
INSERT INTO Logi(kuupaev, andmed, kasutaja)
SELECT
    GETDATE(),
    CONCAT('lisatud kokk: ',inserted.kokkNimi,
		   ' | id: ',inserted.kokkID),
    SYSTEM_USER
FROM inserted;

--kokk DELETE TRIGGER
CREATE TRIGGER KustutaKokk
ON kokk
FOR DELETE
AS
INSERT INTO Logi(kuupaev, andmed, kasutaja)
SELECT
    GETDATE(),
    CONCAT('kustutatud kokk: ',deleted.kokkNimi,
		   ' | id: ',deleted.kokkID),
    SYSTEM_USER
FROM deleted;

--kokk UPDATE TRIGGER
CREATE TRIGGER UuendaKokk
ON kokk
FOR UPDATE
AS
INSERT INTO Logi(kuupaev, andmed, kasutaja)
SELECT
    GETDATE(),
    CONCAT('vana koka andmed: ', deleted.kokkNimi,
		   ', id=', deleted.kokkID, ' || uued koka andmed: ',
        inserted.kokkNimi,', id=', inserted.kokkID),
    SYSTEM_USER
FROM deleted
INNER JOIN inserted
   ON deleted.kokkID = inserted.kokkID;