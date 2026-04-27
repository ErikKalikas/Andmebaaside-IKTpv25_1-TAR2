create database TrigerKalikas
Use TrigerKalikas

--tabel linnad
Create table linnad(
linnId int primary key identity(1,1),
linnaNimi varchar(50) unique,
rahvaarv int not null,
);



--tabel logi
Create table logi(
Id int primary key identity(1,1),
kuupaev Datetime,
andmed TEXT,
kasutaja varchar(50)
);

--maakond
create table maakond(
maakondId int primary key identity(1,1),
maakondNimi varchar(50) unique
);

--foreign key tabelis linnad
ALTER TABLE linnad ADD maakondId int;
SELECT * FROM linnad;
ALTER TABLE linnad ADD CONSTRAINT fk_maakond
FOREIGN KEY (maakondId) REFERENCES maakond(maakondId);

--täidame tabelid
--maakonnad
INSERT INTO maakond
VALUES ('Harjumaa'), ('Pärnumaa'), ('Virumaa');

SELECT * FROM maakond

INSERT INTO linnad (linnaNimi, rahvaarv, maakondId)
VALUES ('Tallinn', 600000, 1), ('Rakvere', 150000, 3);

SELECT * FROM linnad, maakond 
where linnad.maakondId=maakond.maakondId;
--sama päring inner join'iga
SELECT * FROM linnad inner join maakond 
ON linnad.maakondId=maakond.maakondId;


--Triger, mis jälgib kaks seostatud tabelit
Create TRIGGER linnaLisamine
ON linnad 
FOR INSERT
AS
INSERT INTO logi(kuupaev, andmed, kasutaja)
SELECT --values
getdate(),
CONCAT('lisatud linn', inserted.linnanimi, ', ', inserted.rahvaarv, ', ',  m.maakondNimi),
SYSTEM_USER
FROM inserted INNER JOIN maakond m
ON inserted.maakondId=m.maakondId;



--kontroll
INSERT INTO linnad (linnaNimi, rahvaarv, maakondId)
VALUES ('Pärnu', 100000, 2);

SELECT * FROM logi

--triger mis jälgib andmete kustutamine seotud tabelite põhjal

Create TRIGGER linnaKustutamine
ON linnad 
FOR DELETE
AS
INSERT INTO logi(kuupaev, andmed, kasutaja)
SELECT --values
getdate(),
CONCAT('kustutatud linn: ', deleted.linnanimi, ', ', deleted.rahvaarv, ', ',  m.maakondNimi),
SYSTEM_USER
FROM deleted INNER JOIN maakond m
ON deleted.maakondId=m.maakondId;

--kontroll
DELETE from linnad where linnId=12;

INSERT INTO linnad (linnaNimi, rahvaarv, maakondId)
VALUES ('test', 100000, 2);

select * from logi
select * from linnad

DROP TRIGGER linnaKustutamine

--trigger, mis Jälgib andmete uuendamine kahes tabelis
Create TRIGGER linnaUuendamine
ON linnad 
FOR UPDATE
AS
INSERT INTO logi(kuupaev, andmed, kasutaja)
SELECT --values
getdate(),
CONCAT('vana linna andmed: ', deleted.linnanimi, ', ', deleted.rahvaarv, ', ',  m1.maakondNimi,
' || uue linna andmed: ', inserted.linnanimi, ', ', inserted.rahvaarv, ', ',  m2.maakondNimi),
SYSTEM_USER
FROM deleted 
INNER JOIN inserted on deleted.linnId=inserted.linnId
INNER JOIN maakond m1 ON deleted.maakondId=m1.maakondId
INNER JOIN maakond m2 ON inserted.maakondId=m2.maakondId;

--kontroll
SELECT * FROM linnad
SELECT * FROM maakond
UPDATE linnad SET maakondId=2 where linnId=8;

select * from logi
UPDATE linnad SET maakondId=2, linnaNimi='uus Paide' where linnId=8;