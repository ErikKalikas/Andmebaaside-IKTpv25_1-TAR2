CREATE DATABASE KalikasSQL;
use KalikasSQL;

--tabel loomine
CREATE TABLE opilane(
opilaneID int PRIMARY KEY identity(1,1),
eesnimi varchar(25),
perenimi varchar(30) NOT null UNIQUE,
synniaeg date,
aadress TEXT,
kas_opib bit);
--kuvab tabeli, * - kõik väljad
SELECT * FROM opilane;

--tabeli kustutamine
--DROP TABLE opilane;

--andmete lisamine tabelisse opilane 
--lisamine 3.kirjet korraga
INSERT INTO opilane(eesnimi, perenimi, synniaeg,kas_opib)
VALUES ('Nikita', 'petrovm', '2025-12-12', 1),
('Nikita', 'Alekseev', '2020-11-12', 1),
('Nikita', 'Nikita', '2021-12-13', 1);


Select * from opilane;
--muudame tabeli ja lisame piirangu UNIQUE
