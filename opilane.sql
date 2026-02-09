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
SELECT * FROM opilane;
--ühe kirje kustutamine
DELETE FROM opilane WHERE opilaneID=5;

--kirje uuendamine
SELECT * FROM opilane;
UPDATE opilane SET aadress='Tallinn'

SELECT * FROM opilane;

SELECT — выбрать данные

SELECT * FROM users;


INSERT — добавить данные

INSERT INTO users (name, age)
VALUES ('Ivan', 25);


UPDATE — изменить данные

UPDATE users
SET age = 26
WHERE name = 'Ivan';


DELETE — удалить данные

DELETE FROM users
WHERE age < 18;

 Фильтрация и сортировка

WHERE — условия

SELECT * FROM users
WHERE age > 20;


ORDER BY — сортировка

SELECT * FROM users
ORDER BY age DESC;


LIMIT — ограничение количества строк

SELECT * FROM users
LIMIT 10;

Агрегация

COUNT, SUM, AVG, MIN, MAX

SELECT COUNT(*) FROM users;


GROUP BY

SELECT age, COUNT(*)
FROM users
GROUP BY age;


HAVING

SELECT age, COUNT(*)
FROM users
GROUP BY age
HAVING COUNT(*) > 1;

 Работа с таблицами

CREATE TABLE

CREATE TABLE users (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  age INT
);


DROP TABLE

DROP TABLE users;


ALTER TABLE

ALTER TABLE users ADD email VARCHAR(100);

 Соединения таблиц

JOIN

SELECT users.name, orders.amount
FROM users
JOIN orders ON users.id = orders.user_id;
