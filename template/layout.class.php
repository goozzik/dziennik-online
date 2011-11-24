<?php
session_start();
#Do³¹czamy klasy
include_once('class/user.class.php');
include_once('class/mysql.class.php');

#Do³¹czamy funkcje
include_once('functions/text.inc.php');

#Do³¹czamy configi

#£¹czymy siê z db na sta³e
	$mysql = new Mysql();
	$mysql -> connect();
?>