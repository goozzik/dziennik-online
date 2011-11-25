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
  
class layout {

    static public function header_parrent(){
      echo "HTML CODE";
    } 
   
    static public function form_login(){
      echo "<form action='#' method='post'>";
      echo "  <input type='text' name='user_login'>";
      echo "  <input type='text' name='user_password'>";
      echo "  <input type='submit' value='zaloguj'>";
      echo "</form>";
		 
    }
}

?>
