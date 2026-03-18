CREATE DATabase ErikView
USe ErikView

CREATE TABLE uudised(
uudisID int primary key identity(1,1),
uudisPealkiri varchar(50),
kuupaev date,
kirjeldus TEXT,
ajakirjanikID int);

CREATE TABLE ajakirjanik(
ajakirjanikID int primary key identity(1,1),
nimi varchar(50),
telefon varchar(13));

ALTER TABLE uudised ADD CONSTRAINT fk_ajakirjanik
FOREIGN KEY (ajakirjanikID)
REFERENCES ajakirjanik(ajakirjanikID);

INSERT INTO ajakirjanik(nimi,telefon)
values ('Lev','5757755874'),('Anton','57357597')




INSERT into uudised(uudisPealkiri,kuupaev,ajakirjanikID)
values ('Homme on ises töö päev','2025-03-12',1),
('Täna on andmebaaside tund','2025-03-12',1),
('Täna on vihane ilm','2025-03-12',2)

Select * from uudised;
SELECT * FROM ajakirjanik;

--select päring 2 tabelite põhjal
SELECT * FROM uudised,ajakirjanik
WHERE uudised.ajakirjanikID=ajakirjanik.ajakirjanikID;

--alias-nimede kasutamine
SELECT * FROM uudised u,ajakirjanik a
WHERE u.ajakirjanikID=a.ajakirjanikID;

--kitsaim tulemus
SELECT u.uudisPealkiri, a.nimi 
FROM uudised u,ajakirjanik a
WHERE u.ajakirjanikID=a.ajakirjanikID;

--salvestamine vaade
create view loodudUudsed AS
SELECT u.uudisPealkiri, a.nimi 
FROM uudised u,ajakirjanik a
WHERE u.ajakirjanikID=a.ajakirjanikID;

--kutsume salvestatud vaade
SELECT * from loodudUudsed;

--kasutamine view tingimus ka
SELECT * from loodudUudsed
where nimi like 'Lev';

--INNER JOIN - sisemine ühendamine
SELECT u.uudisPealkiri,a.nimi as autor
FROM uudised as u INNER JOIN ajakirjanik as a
ON u.ajakirjanikID=a.ajakirjanikID;

--salvesta
create view kuupaevaUudised as
SELECT u.uudisPealkiri,a.nimi as autor, kuupaev
FROM uudised as u INNER JOIN ajakirjanik as a
ON u.ajakirjanikID=a.ajakirjanikID;


--kuvame salvestatud view päring
select * from kuupaevaUudised;

select uudisPealkiri, YEAR(kuupaev) as aasta 
from kuupaevaUudised;

--3.tabel
CREATE TABLE ajaleht(
ajalehtID int primary key identity(1,1),
ajalehtNimetus varchar(50));
INSERT ajaleht(ajalehtNimetus)
values ('Postimees'),('Delfi');


ALTER TABLE uudised ADD ajalehtID int;
ALTER TABLE uudised ADD constraint fk_ajaleht
FOREIGN KEY (ajalehtID) References ajaleht(ajalehtID);

UPDATE uudised SET ajalehtID=2;
SELECT * FROM ajaleht;
select * from uudised;

--select 3 tabelite põhjal
SELECT u.uudisPealkiri,a.nimi as autor,aj.ajalehtNimetus
FROM (uudised as u INNER JOIN ajakirjanik as a
ON u.ajakirjanikID=a.ajakirjanikID)
INNER JOIN ajaleht as aj
ON u.ajalehtID=aj.ajalehtID;

--loome vaade
create view AutoriUudisedAjalehes as
SELECT u.uudisPealkiri,a.nimi as autor,aj.ajalehtNimetus, kuupaev
FROM (uudised as u INNER JOIN ajakirjanik as a
ON u.ajakirjanikID=a.ajakirjanikID)
INNER JOIN ajaleht as aj
ON u.ajalehtID=aj.ajalehtID;

--kustutame view
DROP view AutoriUudisedAjalehes;

SELECT * FROM AutoriUudisedAjalehes;
SELECT * FROM uudised;

--update view
UPDATE AutoriUudisedAjalehes SET kuupaev='2026-03-18';
--viewUudisedAjakirjanikud.sql lisa Moodlesse ja github'i

--view, mis näitab uudised konkretsel kuupäeval
--oma1 ajakirjuniku view
--oma2 ajalehte view
--kustutada kõik andmebaasid

SELECT u.uudisPealkiri, a.nimi ,kuupaev
FROM uudised u,ajakirjanik a

--oma1 ajakirjaniku view -
create view nimi3tahe as
select * from ajakirjanik
where len(nimi)=3;

select * from nimi3tahe;

--oma2 ajalehte view //
create view ajalehedDtahega AS
select * from ajakirjanik
where ajalehtNimetus like 'D%';

select * from ajalehedDtahega;