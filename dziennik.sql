-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Czas wygenerowania: 05 Mar 2012, 17:10
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
  `date` date DEFAULT NULL,
  `lesson` int(10) unsigned DEFAULT NULL,
  `type` enum('absence','escape','exemption','justification') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=124 ;

--
-- Zrzut danych tabeli `absences`
--

INSERT INTO `absences` (`id`, `student_id`, `class_id`, `date`, `lesson`, `type`) VALUES
(1, 4, 1, '2011-12-26', 4, 'absence'),
(2, 4, 1, '2011-12-26', 3, 'absence'),
(3, 4, 1, '2011-12-26', 3, 'justification'),
(4, 4, 1, '2011-12-26', 3, 'justification'),
(5, 4, 1, '2011-12-26', 1, 'absence'),
(6, 4, 1, '2011-12-26', 1, 'absence'),
(7, 4, 1, '2011-12-26', 1, 'absence'),
(8, 4, 1, '2011-12-26', 3, 'absence'),
(9, 4, 1, '2011-12-26', 3, 'absence'),
(10, 5, 1, '2011-12-26', 3, 'absence'),
(11, 5, 1, '2011-12-26', 3, 'absence'),
(12, 5, 1, '2011-12-26', 3, 'absence'),
(13, 5, 1, '2011-12-26', 2, 'absence'),
(14, 4, 1, '2011-12-26', 0, 'absence'),
(15, 4, 1, '2011-12-26', 0, 'absence'),
(16, 4, 1, '2011-12-26', 2, 'absence'),
(17, 4, 1, '2011-12-26', 2, 'absence'),
(18, 4, 1, '2011-12-26', 2, 'absence'),
(19, 4, 1, '2011-12-26', 2, 'absence'),
(20, 5, 1, '2011-12-26', 4, 'justification'),
(21, 6, 1, '2012-01-17', 4, 'justification'),
(22, 5, 1, '2012-01-21', 2, 'justification'),
(23, 6, 1, '2012-01-17', 4, 'justification'),
(24, 6, 1, '2012-01-17', 4, 'justification'),
(25, 6, 1, '2012-01-17', 4, 'justification'),
(26, 6, 1, '2012-01-17', 4, 'justification'),
(27, 6, 1, '2012-01-17', 4, 'justification'),
(28, 6, 1, '2012-01-17', 4, 'justification'),
(29, 6, 1, '2012-01-17', 4, 'justification'),
(30, 6, 1, '2012-01-17', 4, 'justification'),
(31, 6, 1, '2012-01-17', 4, 'justification'),
(32, 6, 1, '2012-01-17', 4, 'justification'),
(33, 5, 1, '2012-01-17', 4, 'justification'),
(34, 5, 1, '2012-01-17', 4, 'justification'),
(35, 5, 1, '2012-01-17', 4, 'justification'),
(36, 6, 1, '2012-01-17', 6, 'justification'),
(37, 6, 1, '2012-01-17', 6, 'justification'),
(38, 6, 1, '2012-01-17', 6, 'justification'),
(39, 6, 1, '2012-01-17', 6, 'justification'),
(40, 6, 1, '2012-01-17', 6, 'justification'),
(41, 6, 1, '2012-01-17', 6, 'justification'),
(42, 6, 1, '2012-01-17', 6, 'justification'),
(43, 6, 1, '2012-01-17', 5, 'justification'),
(44, 6, 1, '2012-01-17', 5, 'justification'),
(45, 6, 1, '2012-01-17', 5, 'justification'),
(46, 6, 1, '2012-01-17', 5, 'justification'),
(47, 6, 1, '2012-01-17', 0, 'justification'),
(48, 6, 1, '2012-01-17', 0, 'justification'),
(49, 6, 1, '2012-01-17', 0, 'justification'),
(50, 6, 1, '2012-01-17', 0, 'justification'),
(51, 6, 1, '2012-01-17', 0, 'justification'),
(52, 6, 1, '2012-01-17', 0, 'justification'),
(53, 6, 1, '2012-01-17', 0, 'justification'),
(54, 8, 1, '2012-01-17', 0, 'justification'),
(55, 8, 1, '2012-01-17', 0, 'justification'),
(56, 8, 1, '2012-01-17', 0, 'justification'),
(57, 8, 1, '2012-01-17', 0, 'justification'),
(58, 6, 1, '2012-01-17', 0, 'justification'),
(59, 6, 1, '2012-01-17', 0, 'justification'),
(60, 8, 1, '2012-01-17', 0, 'justification'),
(61, 8, 1, '2012-01-17', 0, 'justification'),
(62, 6, 1, '2012-01-17', 0, 'justification'),
(63, 6, 1, '2012-01-17', 0, 'justification'),
(64, 8, 1, '2012-01-17', 0, 'justification'),
(65, 8, 1, '2012-01-17', 0, 'justification'),
(66, 8, 1, '2012-01-17', 0, 'justification'),
(67, 8, 1, '2012-01-17', 0, 'justification'),
(68, 8, 1, '2012-01-17', 0, 'justification'),
(69, 8, 1, '2012-01-17', 0, 'justification'),
(70, 8, 1, '2012-01-17', 0, 'justification'),
(71, 8, 1, '2012-01-17', 0, 'justification'),
(72, 8, 1, '2012-01-17', 0, 'justification'),
(73, 6, 1, '2012-01-17', 0, 'justification'),
(74, 5, 1, '2012-01-17', 0, 'justification'),
(75, 5, 1, '2012-01-17', 0, 'justification'),
(76, 5, 1, '2012-01-17', 0, 'justification'),
(77, 5, 1, '2012-01-17', 0, 'justification'),
(78, 5, 1, '2012-01-17', 0, 'justification'),
(79, 5, 1, '2012-01-17', 0, 'justification'),
(80, 5, 1, '2012-01-17', 0, 'justification'),
(81, 5, 1, '2012-01-17', 0, 'justification'),
(82, 5, 1, '2012-01-17', 0, 'justification'),
(83, 5, 1, '2012-01-17', 0, 'justification'),
(84, 5, 1, '2012-01-17', 0, 'justification'),
(85, 5, 1, '2012-01-17', 0, 'justification'),
(86, 5, 1, '2012-01-17', 0, 'justification'),
(87, 5, 1, '2012-01-17', 0, 'justification'),
(88, 5, 1, '2012-01-17', 0, 'justification'),
(89, 5, 1, '2012-01-17', 0, 'justification'),
(90, 5, 1, '2012-01-17', 0, 'justification'),
(91, 5, 1, '2012-01-17', 0, 'justification'),
(92, 5, 1, '2012-01-17', 0, 'justification'),
(93, 5, 1, '2012-01-17', 0, 'justification'),
(94, 5, 1, '2012-01-17', 0, 'justification'),
(95, 5, 1, '2012-01-17', 0, 'justification'),
(96, 5, 1, '2012-01-17', 0, 'justification'),
(97, 5, 1, '2012-01-17', 0, 'justification'),
(98, 4, 1, '2012-01-17', 0, 'justification'),
(99, 4, 1, '2012-01-17', 0, 'justification'),
(100, 4, 1, '2012-01-17', 0, 'justification'),
(101, 4, 1, '2012-01-17', 0, 'justification'),
(102, 4, 1, '2012-01-17', 0, 'justification'),
(103, 4, 1, '2012-01-21', 2, 'justification'),
(104, 4, 1, '2012-01-21', 2, 'justification'),
(105, 4, 1, '2012-01-21', 2, 'justification'),
(106, 4, 1, '2012-01-21', 2, 'justification'),
(107, 4, 1, '2012-01-21', 2, 'justification'),
(108, 4, 1, '2012-01-21', 2, 'justification'),
(109, 4, 1, '2012-01-21', 2, 'justification'),
(110, 5, 1, '2012-01-21', 2, 'justification'),
(111, 6, 1, '2012-01-21', 2, 'justification'),
(112, 10, 1, '2012-01-17', 3, 'justification'),
(113, 10, 1, '2012-01-17', 2, 'justification'),
(114, 4, 1, '2012-01-17', 2, 'justification'),
(115, 4, 1, '2012-01-17', 3, 'justification'),
(116, 43, 1, '2012-01-24', 0, 'justification'),
(117, 7, 1, '2012-01-24', 0, 'justification'),
(118, 6, 1, '2012-01-24', 8, 'justification'),
(119, 8, 1, '2012-01-24', 5, 'justification'),
(120, 10, 1, '2012-01-24', 5, 'absence'),
(121, 11, 1, '2012-01-24', 5, 'absence'),
(122, 4, 1, '2012-02-06', NULL, NULL),
(123, 11, 1, '2012-02-06', NULL, NULL);

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Zrzut danych tabeli `classes`
--

INSERT INTO `classes` (`id`, `year`, `name`, `profile`, `yearbook`, `school_id`, `teacher_id`) VALUES
(1, 3, 'G', ' informatyk', 2011, NULL, 3),
(2, 4, 'G', 'informatyk', 2011, NULL, 3),
(3, 1, 'G', 'informatyk', 1997, NULL, 3),
(5, 1, 'asdasd', 'asd', 2011, NULL, 3);

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
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Zrzut danych tabeli `descriptions`
--

INSERT INTO `descriptions` (`id`, `type`, `description`, `colour`, `subject_id`) VALUES
(1, '', 'Sprawdzian "To Be"', 0, 1),
(2, '', 'Sprawdzian "MÅ‚oda Polska"', 0, 5),
(3, '', 'asdasd', 0, 5),
(4, '', 'Sprawdzian z Trygonometrii', 0, 2),
(5, '', 'Praca domowa "Just to"', 0, 1),
(6, '', 'Sprawdzian z miÄ™Å›ni', 0, 9),
(7, '', 'Praca domowa "Just to"', 0, 8),
(8, '', 'Sprawdzian z Trygonometrii', 0, 10),
(9, '', 'Asasdasd', 0, 1),
(10, '', '1', 0, 19),
(11, '', '', 0, 19),
(12, '', '', 0, 19),
(13, '', '123123', 0, 19),
(14, '', 'asdasdasdsasad', 0, 19),
(15, '', 'adsasdasdsad', 0, 11),
(16, '', 'sadsadsadads', 0, 11),
(17, '123', '123', 123, 11),
(18, 'aaa', 'aaa', 123, 11),
(19, 'Sprawdzian', 'To be', 4, 11);

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=39 ;

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
(38, 24, 15, 4);

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
  `mark` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=63 ;

--
-- Zrzut danych tabeli `marks`
--

INSERT INTO `marks` (`id`, `student_id`, `class_id`, `semester_id`, `subject_id`, `description_id`, `mark`) VALUES
(1, 46, 1, 2, 1, 1, '1'),
(2, 12, 1, 2, 1, 5, '2'),
(3, 48, 1, 2, 1, 1, '3'),
(4, 8, 1, 2, 1, 1, '4'),
(5, 46, 1, 2, 19, 11, '			'),
(6, 11, 1, 2, 19, 11, '6'),
(7, 48, 1, 2, 19, 11, '3'),
(8, 8, 1, 2, 19, 11, '1'),
(9, 22, 1, 2, 19, 11, '			'),
(10, 46, 1, 2, 19, 10, '			'),
(11, 8, 1, 2, 19, 10, '			'),
(12, 41, 1, 2, 19, 11, '			'),
(13, 19, 1, 2, 19, 12, 'nkl'),
(14, 24, 1, 2, 19, 13, '			'),
(15, 24, 1, 2, 19, 13, '			'),
(16, 25, 1, 2, 19, 11, '			'),
(17, 10, 1, 2, 19, 11, '3'),
(18, 12, 1, 2, 19, 11, '			'),
(19, 49, 1, 2, 19, 11, '			'),
(20, 9, 1, 2, 19, 11, '2'),
(21, 41, 1, 2, 19, 13, '3'),
(22, 47, 1, 2, 19, 11, '3'),
(23, 8, 1, 2, 19, 12, '			'),
(24, 9, 1, 2, 19, 12, '5'),
(25, 41, 1, 2, 19, 12, '5'),
(26, 7, 1, 2, 19, 12, '5'),
(27, 4, 1, 2, 19, 12, '			'),
(28, 49, 1, 2, 19, 12, '			'),
(29, 11, 1, 2, 19, 12, '4'),
(30, 12, 1, 2, 19, 12, '			'),
(31, 46, 1, 2, 19, 12, '			'),
(32, 48, 1, 2, 19, 12, '3'),
(33, 48, 1, 2, 19, 12, '			'),
(34, 25, 1, 2, 19, 12, '3'),
(35, 41, 1, 2, 19, 10, '3'),
(36, 7, 1, 2, 19, 10, '3'),
(37, 17, 1, 2, 19, 12, '1'),
(38, 49, 1, 2, 19, 13, '3'),
(39, 11, 1, 2, 19, 10, '			'),
(40, 9, 1, 2, 19, 13, '4'),
(41, 8, 1, 2, 19, 13, '4'),
(42, 48, 1, 2, 19, 13, '3'),
(43, 11, 1, 2, 19, 13, '4'),
(44, 47, 1, 2, 19, 13, '4'),
(45, 12, 1, 2, 19, 13, '4'),
(46, 46, 1, 2, 19, 13, '			'),
(47, 13, 1, 2, 19, 13, '4'),
(48, 9, 1, 2, 19, 14, '3'),
(49, 25, 1, 2, 19, 13, '3'),
(50, 10, 1, 2, 19, 13, '			'),
(61, 11, 1, 2, 19, 14, '4'),
(51, 10, 1, 2, 19, 12, '6-'),
(52, 6, 1, 2, 19, 10, '3'),
(53, 12, 1, 2, 19, 10, '			'),
(54, 8, 1, 2, 19, 14, '			'),
(55, 48, 1, 2, 19, 14, '			'),
(56, 19, 1, 2, 19, 11, 'zw'),
(57, 16, 1, 2, 19, 12, 'nk'),
(58, 16, 1, 2, 19, 11, '6'),
(59, 28, 1, 2, 19, 11, 'asd'),
(60, 7, 1, 2, 19, 11, '			'),
(62, 49, 1, 2, 19, 10, '			');

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

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
(20, 3, 4);

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

--
-- Zrzut danych tabeli `subjects`
--

INSERT INTO `subjects` (`id`, `school_id`, `teacher_id`, `class_id`, `name`, `deleted`) VALUES
(31, NULL, 3, 1, 'NP', 0),
(30, NULL, 3, 1, 'OB', 0),
(11, NULL, 3, 1, 'asdasd', 0),
(25, NULL, 3, 1, 'Angielski', 0),
(10, NULL, 3, 2, 'Matematyka', 0),
(32, NULL, 3, 1, 'BB', 0),
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Zrzut danych tabeli `teachers`
--

INSERT INTO `teachers` (`id`, `class_id`, `subject_id`, `first_name`, `last_name`, `work_hours`, `telephone`, `mail`) VALUES
(14, 1, 19, 'arek', 'Dudek', '', '48795763205', 'asd@o2.pl'),
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

--
-- Zrzut danych tabeli `time_tables`
--

INSERT INTO `time_tables` (`id`, `class_id`, `week_day`) VALUES
(8, 1, 2),
(14, 1, 1);

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=50 ;

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
(13, 'MateuszOstrowski', '0eb73ab2423e1d82b88ad0ea9920db7ff3c0a088', 'Mateusz', 'Ostrowski', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(14, 'SebastianPiwowarczyk', '52c41d7b1b7b1ca5e45f2fcb3cece116dfd177c5', 'Sebastian', 'Piwowarczyk', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(45, 'ArkadiuszKoÅ¼uch1', '86f7e00637b4634921834d25a5a0dd39749a5dc2', 'Arkadiusz', 'KoÅ¼uch', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 2, 0, 3, 1, 0, 0, 0, 0),
(16, 'ArkadiuszKoÅ¼uch', '86f7e00637b4634921834d25a5a0dd39749a5dc2', 'Arkadiusz', 'KoÅ¼uch', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(17, 'DawidKierat', 'fa109bf3787261186c8f5116be6ace3b2bb0d177', 'Dawid', 'Kierat', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(18, 'MateuszRomaÅ„ski', '093992a3f32692e47ba53bb92b0ca8be9bd8d7e9', 'Mateusz', 'RomaÅ„ski', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(19, 'MichaÅ‚Mijalski', 'dfbcd63606908bf156e2b68111da02274d0b530f', 'MichaÅ‚', 'Mijalski', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(20, 'KamilPjanka', 'cac1a181f38ad493ca5a7e287f75cc2169912700', 'Kamil', 'Pjanka', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(21, 'RafaÅ‚MoÅ„ka', '6fdfb57684f8bd607599fcd54099c38d8d0c3b99', 'RafaÅ‚', 'MoÅ„ka', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(22, 'KrystianKondracki', '3046b65eb460668252e08b28df9bf4733b086b67', 'Krystian', 'Kondracki', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(24, 'Szymon KuczyÅ„ski', '3f1865eb600b5aee2c4d83ef830f3eb201994a2e', 'Szymon ', 'KuczyÅ„ski', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(25, 'MarcinBurdaliÅ„ski', '63ca3aa7de383356c61047a5d3ee3a788de008ec', 'Marcin', 'BurdaliÅ„ski', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(28, 'KrystianMysÅ‚ek', '0ef12186a930fafb1ac82f6a52576a7eea56c886', 'Krystian', 'MysÅ‚ek', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(41, 'ArkadiuszDudek', 'b75b00480251f1feb19506f7ea3b18413dacaa80', 'Arkadiusz', 'Dudek', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(37, 'PiotrKowalski', 'c908704bfaf6dfeba19c67d87036e432a9e82087', 'Piotr', 'Kowalski', 0, '', '', '', '', 0, '', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(46, 'asdasdasd', '6813eba184738211dfc0bb703c68672d12f588b6', 'asd', 'asdasd', 123123, '123123', '', 'sdasd', 'asdasd', 1, '23234234', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(47, 'arekDudek', 'b75b00480251f1feb19506f7ea3b18413dacaa80', 'arek', 'Dudek', 123, '123', '1 maja 11m37', 'Czestochowa', '42217', 14, '123123123', NULL, 0, 0, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(48, 'PiotrBartosik', 'f7c4e390c418ac1e02f337cd1b60aaa21e35632e', 'Piotr', 'Bartosik', 2147483647, 'sasdadssdasad', '1 maja 11m37', 'Czestochowa', '42217', 8, '48795763205', NULL, 1, 1, NULL, 1, 0, 3, 1, 0, 0, 0, 0),
(49, 'PiotrBartosik1', 'f7c4e390c418ac1e02f337cd1b60aaa21e35632e', 'Piotr', 'Bartosik', 123123, '123123', '1 maja 11m37', 'Czestochowa', '42217', 8, '48795763205', NULL, 0, 1, NULL, 1, 0, 3, 1, 0, 0, 0, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
