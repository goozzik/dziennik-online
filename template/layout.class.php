<?php
session_start();
#Do��czamy klasy
include_once('class/user.class.php');
include_once('class/mysql.class.php');

#Do��czamy funkcje
include_once('functions/text.inc.php');

#Do��czamy configi

#��czymy si� z db na sta�e
	$mysql = new Mysql();
	$mysql -> connect();
?>