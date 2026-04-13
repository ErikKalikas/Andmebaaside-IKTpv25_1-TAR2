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
Values ('test2', 60000);

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
DELETe from linnad where linnId=5;

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
SELECT * FROM linnad;
UPDATE linnad Set linnaNimi = 'Tapa uus', rahvaarv=25
WHERE linnId=5;

SELEct * FROM linnad
SELECT * FROM logi

--lisame kasutajaNimi logi tabelisse
ALTER table logi ADD kasutaja varchar(40);