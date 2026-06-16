-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Июн 16 2026 г., 07:29
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `koolitoit`
--

-- --------------------------------------------------------

--
-- Структура таблицы `kokk`
--

CREATE TABLE `kokk` (
  `kokkID` int(11) NOT NULL,
  `kokkNimi` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Триггеры `kokk`
--
DELIMITER $$
CREATE TRIGGER `KustutaKokk` AFTER DELETE ON `kokk` FOR EACH ROW BEGIN
    INSERT INTO logi (kuupaev, andmed, kasutaja)
    VALUES (
        NOW(),
        CONCAT('kustutatud kokk: ', OLD.kokkNimi, ' | id: ', OLD.kokkID),
        USER()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `LisaKokk` AFTER INSERT ON `kokk` FOR EACH ROW BEGIN
    INSERT INTO logi (kuupaev, andmed, kasutaja)
    VALUES (
        NOW(),
        CONCAT('lisatud kokk: ', NEW.kokkNimi, ' | id: ', NEW.kokkID),
        USER()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UuendaKokk` AFTER UPDATE ON `kokk` FOR EACH ROW BEGIN
    INSERT INTO logi (kuupaev, andmed, kasutaja)
    VALUES (
        NOW(),
        CONCAT('vana koka andmed: ', OLD.kokkNimi, ', id=', OLD.kokkID, 
               ' || uued koka andmed: ', NEW.kokkNimi, ', id=', NEW.kokkID),
        USER()
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `logi`
--

CREATE TABLE `logi` (
  `logiID` int(11) NOT NULL,
  `kuupaev` datetime DEFAULT current_timestamp(),
  `andmed` text DEFAULT NULL,
  `kasutaja` varchar(100) DEFAULT user()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `logi`
--

INSERT INTO `logi` (`logiID`, `kuupaev`, `andmed`, `kasutaja`) VALUES
(1, '2026-06-16 06:54:39', 'lisatud kokk: Erik | id: 1', 'root@localhost'),
(2, '2026-06-16 06:56:46', 'roa nimi on: sealiha | hind on: 5 | id: 1', 'root@localhost'),
(3, '2026-06-16 07:32:43', 'vana koka andmed: Erik, id=1 || uued koka andmed: maksim, id=1', 'root@localhost'),
(4, '2026-06-16 07:33:13', 'kustutatud roa nimi on: sealiha | hind on: 5 | id: 1 | koka id: 1', 'root@localhost'),
(5, '2026-06-16 07:51:52', 'roa nimi on: kala | hind on: 5 | id: 2 | koka id: 1', 'KalikasT@localhost'),
(6, '2026-06-16 07:55:46', 'vana roa andmed: kala, 5, id=2, koka id=1 || uued roa andmed: sealiha, 5, id=2, koka id=1', 'KalikasT@localhost'),
(7, '2026-06-16 07:55:52', 'kustutatud roa nimi on: sealiha | hind on: 5 | id: 2 | koka id: 1', 'KalikasT@localhost'),
(8, '2026-06-16 07:56:39', 'kustutatud kokk: maksim | id: 1', 'KalikasT@localhost');

-- --------------------------------------------------------

--
-- Структура таблицы `toidud`
--

CREATE TABLE `toidud` (
  `Id` int(11) NOT NULL,
  `nimetus` varchar(50) DEFAULT NULL,
  `hind` int(11) DEFAULT NULL,
  `kokkID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Триггеры `toidud`
--
DELIMITER $$
CREATE TRIGGER `KasutaToit` AFTER DELETE ON `toidud` FOR EACH ROW BEGIN
    INSERT INTO logi (kuupaev, andmed, kasutaja)
    VALUES (
        NOW(),
        CONCAT('kustutatud roa nimi on: ', OLD.nimetus, ' | hind on: ', OLD.hind, ' | id: ', OLD.Id, ' | koka id: ', OLD.kokkID),
        USER()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `LisaToit` AFTER INSERT ON `toidud` FOR EACH ROW BEGIN
    INSERT INTO logi (kuupaev, andmed, kasutaja)
    VALUES (
        NOW(),
        CONCAT('roa nimi on: ', NEW.nimetus, ' | hind on: ', NEW.hind, ' | id: ', NEW.Id, ' | koka id: ', NEW.kokkID),
        USER()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UuendaToit` AFTER UPDATE ON `toidud` FOR EACH ROW BEGIN
    INSERT INTO logi (kuupaev, andmed, kasutaja)
    VALUES (
        NOW(),
        CONCAT('vana roa andmed: ', OLD.nimetus, ', ', OLD.hind, ', id=', OLD.Id, ', koka id=', OLD.kokkID, 
               ' || uued roa andmed: ', NEW.nimetus, ', ', NEW.hind, ', id=', NEW.Id, ', koka id=', NEW.kokkID),
        USER()
    );
END
$$
DELIMITER ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `kokk`
--
ALTER TABLE `kokk`
  ADD PRIMARY KEY (`kokkID`);

--
-- Индексы таблицы `logi`
--
ALTER TABLE `logi`
  ADD PRIMARY KEY (`logiID`);

--
-- Индексы таблицы `toidud`
--
ALTER TABLE `toidud`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `kokkID` (`kokkID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `kokk`
--
ALTER TABLE `kokk`
  MODIFY `kokkID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `logi`
--
ALTER TABLE `logi`
  MODIFY `logiID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `toidud`
--
ALTER TABLE `toidud`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `toidud`
--
ALTER TABLE `toidud`
  ADD CONSTRAINT `toidud_ibfk_1` FOREIGN KEY (`kokkID`) REFERENCES `kokk` (`kokkID`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
