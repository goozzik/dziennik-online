-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Czas wygenerowania: 17 Mar 2012, 11:31
-- Wersja serwera: 5.1.41
-- Wersja PHP: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Baza danych: `dziennik`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla  `absences`
--

CREATE TABLE IF NOT EXISTS `absences` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `student_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `absence_report_id` int(10) unsigned DEFAULT NULL,
  `date` date DEFAULT NULL,
  `required` int(3) unsigned DEFAULT NULL,
  `justified` int(3) unsigned DEFAULT NULL,
  `unexcused` int(3) unsigned DEFAULT NULL,
  `late` int(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=173 ;

--
-- Zrzut danych tabeli `absences`
--

INSERT INTO `absences` (`id`, `student_id`, `class_id`, `absence_report_id`, `date`, `required`, `justified`, `unexcused`, `late`) VALUES
(125, 4, 1, NULL, '2012-03-05', 10, 1, 3, 6),
(126, 4, 1, NULL, '2012-03-12', 40, NULL, NULL, NULL),
(127, 43, 1, NULL, '2012-03-05', 14, 1, NULL, NULL),
(128, 6, 1, NULL, '2012-03-05', NULL, NULL, NULL, NULL),
(129, 7, 1, NULL, '2012-03-05', 12, 6, NULL, NULL),
(130, 8, 1, NULL, '2012-03-05', 12, 2, NULL, NULL),
(131, 10, 1, NULL, '2012-03-05', 12, 3, NULL, NULL),
(132, 9, 1, NULL, '2012-03-05', 22, 12, NULL, NULL),
(133, 11, 1, NULL, '2012-03-05', 12, 11, NULL, NULL),
(134, 13, 1, NULL, '2012-03-05', 12, 4, NULL, NULL),
(135, 14, 1, NULL, '2012-03-05', 12, 2, NULL, NULL),
(136, 16, 1, NULL, '2012-03-05', 12, 3, NULL, NULL),
(137, 17, 1, NULL, '2012-03-05', 12, 5, NULL, NULL),
(138, 18, 1, NULL, '2012-03-05', 12, 5, NULL, NULL),
(139, 12, 1, NULL, '2012-03-05', 12, 10, NULL, NULL),
(140, 19, 1, NULL, '2012-03-05', 12, 4, NULL, NULL),
(141, 20, 1, NULL, '2012-03-05', 12, 2, NULL, NULL),
(142, 21, 1, NULL, '2012-03-05', 12, 8, NULL, NULL),
(143, 22, 1, NULL, '2012-03-05', 12, 7, NULL, NULL),
(144, 24, 1, NULL, '2012-03-05', 12, 1, NULL, NULL),
(145, 25, 1, NULL, '2012-03-05', 12, 8, NULL, NULL),
(146, 41, 1, NULL, '2012-03-05', 12, 7, NULL, NULL),
(147, 28, 1, NULL, '2012-03-05', 12, 8, NULL, NULL),
(148, 37, 1, NULL, '2012-03-05', 12, 6, NULL, NULL),
(149, 50, 1, NULL, '2012-03-05', 12, 7, NULL, NULL),
(150, 47, 1, NULL, '2012-03-05', 12, 9, NULL, NULL),
(151, 48, 1, NULL, '2012-03-05', 12, 9, NULL, NULL),
(152, 49, 1, NULL, '2012-03-05', 12, 9, NULL, NULL),
(153, 43, 1, NULL, '2012-03-12', 10, NULL, NULL, NULL),
(154, 6, 1, NULL, '2012-03-12', 40, 10, NULL, 1),
(155, 7, 1, NULL, '2012-03-19', NULL, NULL, NULL, NULL),
(156, 52, 1, NULL, '2012-05-14', NULL, NULL, NULL, NULL),
(157, 4, 1, NULL, '2012-03-19', 11, 3, NULL, NULL),
(158, 7, 1, NULL, '2012-03-12', NULL, NULL, NULL, NULL),
(159, 14, 1, NULL, '2012-03-12', 40, 18, 11, NULL),
(160, 43, 1, NULL, '2012-03-19', NULL, NULL, NULL, NULL),
(161, 6, 1, NULL, '2012-03-19', NULL, NULL, NULL, NULL),
(162, 8, 1, NULL, '2012-03-12', NULL, NULL, NULL, NULL),
(163, 9, 1, NULL, '2012-03-12', 40, 11, NULL, NULL),
(164, 10, 1, NULL, '2012-03-12', NULL, 11, NULL, NULL),
(165, 11, 1, NULL, '2012-03-12', NULL, 11, NULL, NULL),
(166, 13, 1, NULL, '2012-03-12', NULL, 12, NULL, NULL),
(167, 12, 1, NULL, '2012-03-12', NULL, NULL, NULL, NULL),
(168, 14, 1, NULL, '2012-03-19', 30, NULL, 11, NULL),
(169, 48, 1, NULL, '2012-03-12', NULL, NULL, NULL, NULL),
(170, 16, 1, NULL, '2012-03-19', NULL, NULL, NULL, NULL),
(171, 17, 1, NULL, '2012-03-12', NULL, 2, NULL, NULL),
(172, 43, 1, NULL, '2012-04-02', 40, 11, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla  `absence_reports`
--

CREATE TABLE IF NOT EXISTS `absence_reports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `student_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `date` date DEFAULT NULL,
  `percentage` float unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=29 ;

--
-- Zrzut danych tabeli `absence_reports`
--

INSERT INTO `absence_reports` (`id`, `student_id`, `class_id`, `date`, `percentage`) VALUES
(1, 4, NULL, '2012-03-05', 88.5246),
(2, 43, NULL, '2012-03-05', 95.8333),
(3, 6, NULL, '2012-03-05', 75),
(4, 7, NULL, '2012-03-05', 50),
(5, 8, NULL, '2012-03-05', 83.3333),
(6, 10, NULL, '2012-03-05', 0),
(7, 9, NULL, '2012-03-05', 62.9032),
(8, 11, NULL, '2012-03-05', 0),
(9, 12, NULL, '2012-03-05', 16.6667),
(10, 13, NULL, '2012-03-05', 0),
(11, 14, NULL, '2012-03-05', 48.7805),
(12, 16, NULL, '2012-03-05', 75),
(13, 17, NULL, '2012-03-05', 41.6667),
(14, 18, NULL, '2012-03-05', 58.3333),
(15, 19, NULL, '2012-03-05', 66.6667),
(16, 20, NULL, '2012-03-05', 16.6667),
(17, 21, NULL, '2012-03-05', 33.3333),
(18, 22, NULL, '2012-03-05', 41.6667),
(19, 24, NULL, '2012-03-05', 91.6667),
(20, 25, NULL, '2012-03-05', 33.3333),
(21, 28, NULL, '2012-03-05', 33.3333),
(22, 41, NULL, '2012-03-05', 41.6667),
(23, 37, NULL, '2012-03-05', 50),
(24, 50, NULL, '2012-03-05', 41.6667),
(25, 47, NULL, '2012-03-05', 25),
(26, 48, NULL, '2012-03-05', 25),
(27, 49, NULL, '2012-03-05', 25),
(28, 43, NULL, '2012-04-02', 72.5);

-- --------------------------------------------------------

--
-- Struktura tabeli dla  `bells`
--

CREATE TABLE IF NOT EXISTS `bells` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `school_id` int(10) unsigned DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Zrzut danych tabeli `bells`
--


-- --------------------------------------------------------

--
-- Struktura tabeli dla  `classes`
--

CREATE TABLE IF NOT EXISTS `classes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `year` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `profile` varchar(255) NOT NULL,
  `yearbook` int(10) unsigned DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT NULL,
  `teacher_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Zrzut danych tabeli `classes`
--

INSERT INTO `classes` (`id`, `year`, `name`, `profile`, `yearbook`, `school_id`, `teacher_id`) VALUES
(1, 3, 'G', ' informatyk', 2011, NULL, 3),
(2, 4, 'G', 'informatyk', 2011, NULL, 3),
(3, 1, 'G', 'informatyk', 1997, NULL, 3),
(5, 1, 'asdasd', 'asd', 2011, NULL, 3),
(6, 1, '1H', 'Biol-Chem', 2011, NULL, 3);

-- --------------------------------------------------------

--
-- Struktura tabeli dla  `descriptions`
--

CREATE TABLE IF NOT EXISTS `descriptions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `colour` tinyint(4) NOT NULL,
  `subject_id` tinyint(3) unsigned DEFAULT NULL,
  `semester_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=24 ;

--
-- Zrzut danych tabeli `descriptions`
--

INSERT INTO `descriptions` (`id`, `type`, `description`, `colour`, `subject_id`, `semester_id`) VALUES
(1, '123', '123123', 1, 31, 0),
(2, '1231123123123', '12312313123123', 1, 31, 0),
(3, '123123', '123123', 123, 25, 0),
(4, 'KartkÃ³wka', '123', 123, 31, 0),
(5, '23456789', '1234', 2, 31, 0),
(6, 'rrrr', 'rrr', 1, 31, 0),
(7, '123', '321', 99, 31, 0),
(8, '1', '1', 1, 31, 0),
(9, '1', '1', 1, 31, 0),
(10, '1', '1', 1, 31, 0),
(15, 'KartkÃ³wka', 'Sprawdzian z Trygonometrii', 1, 31, 2),
(18, '123', 'Sprawdzian z Trygonometrii', 1, 31, 1),
(19, 'KartkÃ³wka', 'Sprawdzian z Trygonometrii', 1, 30, 1),
(20, 'KartkÃ³wka', 'z Trygonometrii', 1, 33, 1),
(21, 'KartkÃ³wka', 'Pitagoras', 1, 33, 1),
(22, 'KartkÃ³wka', 'Sprawdzian z Trygonometrii', 1, 33, 2),
(23, 'KartkÃ³wka', 'Sprawdzian z Trygonometrii', 1, 33, 2);

-- --------------------------------------------------------

--
-- Struktura tabeli dla  `documents`
--

CREATE TABLE IF NOT EXISTS `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL,
  `semester_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `path` text NOT NULL,
  `type` varchar(255) NOT NULL,
  `size` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Zrzut danych tabeli `documents`
--

INSERT INTO `documents` (`id`, `class_id`, `semester_id`, `name`, `description`, `path`, `type`, `size`, `date`) VALUES
(1, 1, 1, '0_2.jpg', 'asd', 'asd', 'image/jpeg', 273190, '2012-03-06 14:43:44'),
(2, 1, 1, '1_2.jpg', 'asd', 'C:/xampp/htdocs/dziennik-online/app/webroot/documents/files/1_2.jpg', 'image/jpeg', 273190, '2012-03-06 14:51:38'),
(9, 1, 2, '0_to do - dziennik.txt', 'Nowy szablon testowy plik', 'C:\\xampp\\htdocs\\dziennik-online\\app\\webroot\\documents\\files\\0_to do - dziennik.txt', 'text/plain', 715, '2012-03-10 13:35:57');

-- --------------------------------------------------------

--
-- Struktura tabeli dla  `lessons`
--

CREATE TABLE IF NOT EXISTS `lessons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `time_table_id` int(10) unsigned DEFAULT NULL,
  `lesson_number` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=55 ;

--
-- Zrzut danych tabeli `lessons`
--

INSERT INTO `lessons` (`id`, `subject_id`, `time_table_id`, `lesson_number`) VALUES
(1, 1, 1, 0),
(2, 2, 1, 1),
(3, 2, 1, 2),
(4, 4, 1, 3),
(5, 5, 1, 4),
(6, 1, 8, 0),
(7, 1, 8, 1),
(8, 1, 8, 2),
(9, 1, 8, 3),
(10, 1, 8, 4),
(11, 1, 8, 5),
(12, 1, 8, 6),
(13, 1, 8, 7),
(14, 1, 8, 8),
(15, 1, 8, 9),
(16, 2, 9, 0),
(17, 2, 9, 1),
(18, 1, 10, 2),
(19, 8, 11, 0),
(20, 2, 11, 1),
(21, 8, 11, 2),
(22, 19, 12, 0),
(23, 17, 12, 1),
(24, 19, 12, 2),
(25, 24, 12, 5),
(26, 24, 12, 6),
(27, 24, 13, 0),
(28, 24, 13, 1),
(29, 17, 13, 2),
(30, 17, 14, 1),
(31, 19, 14, 2),
(32, 19, 14, 3),
(33, 19, 14, 4),
(34, 21, 15, 0),
(35, 20, 15, 1),
(36, 17, 15, 2),
(37, 20, 15, 3),
(38, 24, 15, 4),
(39, 25, 18, 0),
(40, 30, 18, 1),
(41, 25, 18, 2),
(42, 11, 18, 3),
(43, 25, 19, 0),
(44, 32, 19, 1),
(45, 32, 19, 2),
(46, 11, 19, 4),
(47, 30, 20, 0),
(48, 11, 20, 1),
(49, 11, 20, 2),
(50, 25, 21, 0),
(51, 25, 21, 1),
(52, 28, 21, 2),
(53, 26, 21, 3),
(54, 26, 21, 4);

-- --------------------------------------------------------

--
-- Struktura tabeli dla  `marks`
--

CREATE TABLE IF NOT EXISTS `marks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `student_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `semester_id` int(11) NOT NULL,
  `subject_id` tinyint(3) unsigned DEFAULT NULL,
  `description_id` int(10) unsigned DEFAULT NULL,
  `mark` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=31 ;

--
-- Zrzut danych tabeli `marks`
--

INSERT INTO `marks` (`id`, `student_id`, `class_id`, `semester_id`, `subject_id`, `description_id`, `mark`) VALUES
(1, 51, 1, 2, 25, 3, '2'),
(2, 52, 1, 2, 25, 3, '2'),
(3, 12, 1, 2, 25, 3, '3'),
(4, 48, 1, 2, 25, 3, '2'),
(5, 50, 1, 2, 25, 3, '3'),
(6, 8, 1, 2, 25, 3, '3'),
(7, 49, 1, 2, 25, 3, '3'),
(8, 11, 1, 2, 25, 3, '3'),
(9, 17, 1, 2, 25, 3, '3'),
(10, 4, 1, 2, 25, 3, '3'),
(11, 7, 1, 2, 25, 3, '3'),
(12, 47, 1, 2, 25, 3, ''),
(13, 22, 1, 2, 25, 3, '3'),
(14, 37, 1, 2, 25, 3, '3'),
(15, 19, 1, 2, 25, 3, '3'),
(16, 21, 1, 2, 25, 3, '3 '),
(17, 14, 1, 2, 25, 3, '1-'),
(18, 52, 1, 2, 31, 1, '3 '),
(19, 52, 1, 2, 31, 2, '4-'),
(20, 51, 1, 2, 31, 15, '5 '),
(21, 12, 1, 2, 31, 15, ''),
(22, 51, 1, 1, 30, 19, '1'),
(23, 11, 1, 1, 30, 19, '2'),
(24, 48, 1, 1, 30, 19, '3'),
(25, 8, 1, 1, 30, 19, '4-'),
(26, 10, 1, 1, 30, 19, '3-'),
(27, 12, 1, 1, 33, 20, '2'),
(28, 12, 1, 1, 33, 21, '3'),
(29, 4, 1, 2, 33, 22, '3'),
(30, 4, 1, 2, 33, 23, '5 ');

-- --------------------------------------------------------

--
-- Struktura tabeli dla  `mark_semesters`
--

CREATE TABLE IF NOT EXISTS `mark_semesters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `student_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `semester_id` int(11) NOT NULL,
  `subject_id` tinyint(3) unsigned DEFAULT NULL,
  `mark` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

--
-- Zrzut danych tabeli `mark_semesters`
--

INSERT INTO `mark_semesters` (`id`, `student_id`, `class_id`, `semester_id`, `subject_id`, `mark`) VALUES
(1, 11, 1, 2, 31, '4 '),
(2, 48, 1, 2, 25, '3 '),
(3, 9, 1, 2, 31, '4'),
(4, 10, 1, 2, 31, '5'),
(5, 41, 1, 2, 31, 'zw'),
(6, 47, 1, 2, 31, '6'),
(7, 49, 1, 2, 31, '4a'),
(8, 7, 1, 2, 31, '5'),
(9, 17, 1, 2, 31, '2'),
(10, 25, 1, 2, 31, '3'),
(11, 8, 1, 2, 31, '4 '),
(12, 52, 1, 2, 31, 'nkl'),
(13, 12, 1, 2, 31, 'zw'),
(14, 50, 1, 2, 31, '4-'),
(15, 4, 1, 2, 33, '4'),
(16, 37, 1, 2, 31, '3'),
(17, 22, 1, 2, 31, '1'),
(18, 43, 1, 2, 31, '1'),
(19, 16, 1, 2, 31, '4'),
(20, 19, 1, 2, 31, '5'),
(21, 21, 1, 2, 25, '5-'),
(22, 24, 1, 2, 31, '5'),
(23, 51, 1, 2, 31, '5 '),
(24, 28, 1, 2, 31, '6'),
(25, 13, 1, 2, 31, '6'),
(26, 14, 1, 2, 31, '6'),
(27, 6, 1, 2, 31, '6'),
(28, 18, 1, 2, 31, '6'),
(29, 12, 1, 1, 33, '2'),
(30, 52, 1, 1, 30, '2'),
(31, 51, 1, 1, 30, '3'),
(32, 11, 1, 1, 30, '3');

-- --------------------------------------------------------

--
-- Struktura tabeli dla  `notes`
--

CREATE TABLE IF NOT EXISTS `notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `description` text,
  `teacher_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Zrzut danych tabeli `notes`
--


-- --------------------------------------------------------

--
-- Struktura tabeli dla  `schools`
--

CREATE TABLE IF NOT EXISTS `schools` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `adress` varchar(255) NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Zrzut danych tabeli `schools`
--


-- --------------------------------------------------------

--
-- Struktura tabeli dla  `semesters`
--

CREATE TABLE IF NOT EXISTS `semesters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL,
  `semester` int(11) NOT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Zrzut danych tabeli `semesters`
--

INSERT INTO `semesters` (`id`, `class_id`, `semester`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 2, 1),
(5, 1, 4),
(6, 3, 1),
(7, 2, 2),
(8, 2, 3),
(9, 3, 2),
(10, 1, 5),
(11, 1, 6),
(12, 1, 7),
(13, 1, 8),
(14, 1, 9),
(15, 2, 4),
(16, 1, 10),
(17, 3, 3),
(18, 5, 1),
(19, 5, 2),
(20, 3, 4),
(21, 6, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla  `subjects`
--

CREATE TABLE IF NOT EXISTS `subjects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `school_id` int(10) unsigned DEFAULT NULL,
  `teacher_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=34 ;

--
-- Zrzut danych tabeli `subjects`
--

INSERT INTO `subjects` (`id`, `school_id`, `teacher_id`, `class_id`, `name`, `deleted`) VALUES
(33, NULL, 3, 1, 'Matematyka', 0),
(30, NULL, 3, 1, 'OB', 0),
(25, NULL, 3, 1, 'Angielski', 0),
(10, NULL, 3, 2, 'Matematyka', 0),
(26, NULL, 3, 1, 'Niemiecki', 0),
(27, NULL, 3, 1, 'JapoÅ„ski', 0),
(28, NULL, 3, 1, 'WÅ‚oski', 0),
(29, NULL, 3, 1, 'PO', 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla  `teachers`
--

CREATE TABLE IF NOT EXISTS `teachers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int(10) unsigned DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `work_hours` text NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `mail` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Zrzut danych tabeli `teachers`
--

INSERT INTO `teachers` (`id`, `class_id`, `subject_id`, `first_name`, `last_name`, `work_hours`, `telephone`, `mail`) VALUES
(20, 1, 27, 'Dudek', 'Bartosik', '', '123123123', 'asd@o2.pl'),
(19, 1, 30, 'asdasd', 'Bartosik', '', '123123-123123', 'asd@o2.pl');

-- --------------------------------------------------------

--
-- Struktura tabeli dla  `time_tables`
--

CREATE TABLE IF NOT EXISTS `time_tables` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int(10) unsigned DEFAULT NULL,
  `week_day` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Zrzut danych tabeli `time_tables`
--

INSERT INTO `time_tables` (`id`, `class_id`, `week_day`) VALUES
(21, 1, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla  `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` char(50) DEFAULT NULL,
  `password` char(40) DEFAULT NULL,
  `first_name` varchar(32) DEFAULT NULL,
  `last_name` varchar(32) DEFAULT NULL,
  `pesel` int(11) NOT NULL,
  `niu` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `zip_code` varchar(6) NOT NULL,
  `province` int(11) NOT NULL,
  `telephone` varchar(50) NOT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `individual` tinyint(1) NOT NULL,
  `boarding_school` tinyint(1) NOT NULL,
  `school_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `semester_id` int(11) NOT NULL,
  `teacher_id` int(10) unsigned DEFAULT NULL,
  `student` tinyint(1) NOT NULL DEFAULT '0',
  `teacher` tinyint(1) NOT NULL DEFAULT '0',
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `superadmin` tinyint(1) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=54 ;

--
-- Zrzut danych tabeli `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `first_name`, `last_name`, `pesel`, `niu`, `street`, `city`, `zip_code`, `province`, `telephone`, `mail`, `individual`, `boarding_school`, `school_id`, `class_id`, `semester_id`, `teacher_id`, `student`, `teacher`, `admin`, `superadmin`, `deleted`) VALUES
(1, 'superadmin', 'f1bab0da1e3744bc9c22d63be1af16f5e4f76fc4', NULL, NULL, 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, NULL, 0, NULL, 0, 0, 0, 1, 0),
(2, 'admin', 'f1bab0da1e3744bc9c22d63be1af16f5e4f76fc4', NULL, NULL, 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, NULL, 0, NULL, 0, 0, 1, 0, 0),
(3, 'teacher', 'f1bab0da1e3744bc9c22d63be1af16f5e4f76fc4', 'Karolina', 'Olczak', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 2, NULL, 0, 1, 0, 0, 0),
(4, 'student', 'f1bab0da1e3744bc9c22d63be1af16f5e4f76fc4', 'Jakub', 'Gorzelak', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(43, 'JanKowalski', 'c908704bfaf6dfeba19c67d87036e432a9e82087', 'Jan', 'Kowalski', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(6, 'MateuszPÅ‚aszczyÅ„ski', 'a327158220ade02c56064ea1a6fa309d57fac8a3', 'Mateusz', 'PÅ‚aszczyÅ„ski', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(7, 'Konrad Gandera', 'fc6f11ecac534acb14a3c4b8d21d22a4c76a248e', 'Konrad ', 'Gandera', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(8, 'KamilBenduch', '567a61ed792a39d70df5b6e3aad756077c9f6696', 'Kamil', 'Benduch', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(9, 'BartÅ‚omiejChereÅºniak', '37bfb1090281dda7f84f08b42a0bb6a724826765', 'BartÅ‚omiej', 'ChereÅºniak', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(10, 'Dawid ChwaÅ‚owski', '8a0596599ffb73fa3335054c4117247258e8548b', 'Dawid ', 'ChwaÅ‚owski', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(11, 'BartoszBartosik', 'f7c4e390c418ac1e02f337cd1b60aaa21e35632e', 'Bartosz', 'Bartosik', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(12, 'DominikBagmat', 'c79dcc7c1e6b24ef285ed4a5895ef35ef40a7071', 'Dominik', 'Bagmat', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(14, 'SebastianPiwowarczyk', '52c41d7b1b7b1ca5e45f2fcb3cece116dfd177c5', 'Sebastian', 'Piwowarczyk', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(45, 'ArkadiuszKoÅ¼uch1', '86f7e00637b4634921834d25a5a0dd39749a5dc2', 'Arkadiusz', 'KoÅ¼uch', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 2, 0, 3, 1, 0, 0, 0, 0),
(16, 'ArkadiuszKoÅ¼uch', '86f7e00637b4634921834d25a5a0dd39749a5dc2', 'Arkadiusz', 'KoÅ¼uch', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(17, 'DawidKierat', 'fa109bf3787261186c8f5116be6ace3b2bb0d177', 'Dawid', 'Kierat', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(18, 'MateuszRomaÅ„ski', '093992a3f32692e47ba53bb92b0ca8be9bd8d7e9', 'Mateusz', 'RomaÅ„ski', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(19, 'MichaÅ‚Mijalski', 'dfbcd63606908bf156e2b68111da02274d0b530f', 'MichaÅ‚', 'Mijalski', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(51, 'Dudek123123', 'b0d1f5386adcf43b16f16ff4cc5d55e0c53d7126', 'Dudek', '123123', 123123, '123132', '1 maja 11m37', 'Czestochowa', '42217', 8, '48795763205', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(21, 'RafaÅ‚MoÅ„ka', '6fdfb57684f8bd607599fcd54099c38d8d0c3b99', 'RafaÅ‚', 'MoÅ„ka', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(22, 'KrystianKondracki', '3046b65eb460668252e08b28df9bf4733b086b67', 'Krystian', 'Kondracki', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(24, 'Szymon KuczyÅ„ski', '3f1865eb600b5aee2c4d83ef830f3eb201994a2e', 'Szymon ', 'KuczyÅ„ski', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(25, 'MarcinBurdaliÅ„ski', '63ca3aa7de383356c61047a5d3ee3a788de008ec', 'Marcin', 'BurdaliÅ„ski', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(28, 'KrystianMysÅ‚ek', '0ef12186a930fafb1ac82f6a52576a7eea56c886', 'Krystian', 'MysÅ‚ek', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(41, 'ArkadiuszDudek', 'b75b00480251f1feb19506f7ea3b18413dacaa80', 'Arkadiusz', 'Dudek', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(37, 'PiotrKowalski', 'c908704bfaf6dfeba19c67d87036e432a9e82087', 'Piotr', 'Kowalski', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(50, 'PiotrBartosik2', 'f7c4e390c418ac1e02f337cd1b60aaa21e35632e', 'Piotr', 'Bartosik', 123123, 'sasdadssdasad', '1 maja 11m37', 'Czestochowa', '42217', 8, '48795763205', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(47, 'arekDudek', 'b75b00480251f1feb19506f7ea3b18413dacaa80', 'arek', 'Dudek', 123, '123', '1 maja 11m37', 'Czestochowa', '42217', 14, '123123123', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(48, 'PiotrBartosik', 'f7c4e390c418ac1e02f337cd1b60aaa21e35632e', 'Piotr', 'Bartosik', 2147483647, 'sasdadssdasad', '1 maja 11m37', 'Czestochowa', '42217', 8, '48795763205', NULL, 1, 1, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(49, 'PiotrBartosik1', 'f7c4e390c418ac1e02f337cd1b60aaa21e35632e', 'Piotr', 'Bartosik', 123123, '123123', '1 maja 11m37', 'Czestochowa', '42217', 8, '48795763205', NULL, 0, 1, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(52, 'Dudekasd', '7df1240e316d96bb996fa3a0a413cb3113310940', 'Dudek', 'asd', 123123, '123', '1 maja 11m37', 'Czestochowa', '42217', 8, '48795763205', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
