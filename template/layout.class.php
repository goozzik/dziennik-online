<?php
  session_start();
  include_once('class/user.class.php');
  include_once('class/mysql.class.php');

  include_once('functions/text.inc.php');

    $mysql = new Mysql();
    $mysql -> connect();

  class layout {

      static public function head(){
        echo "<head>";
        echo "  <link rel='stylesheet' type='text/css' href='/css/default.css'>";
        echo "  <meta content='text/html; charset=UTF-8' http-equiv='Content-Type'>";
        echo "</head>";
      }

      static public function content(){
        echo "<div id='content'>";
      }

      static public function div_end(){
        echo "</div>";
      }

      static public function header_parrent(){
        echo "HTML CODE";
      }

      static public function user_login_form(){
        echo "<form action='#' method='post'>";
        echo "  <div>";
        echo "    <label>Login</label>";
        echo "    <input type='text' name='user_login'>";
        echo "  </div>";
        echo "  <div>";
        echo "    <label>Has¿o</label>";
        echo "    <input type='text' name='user_password'>";
        echo "  </div>";
        echo "  <div>";
        echo "    <input type='submit' value='Zaloguj'>";
        echo "  </div>";
        echo "</form>";
      }

      static public function sign_in_link(){
        echo "<a href='/user_login.php'>Zaloguj</a>";
      }

      static public function sign_out_link(){
        echo "<a href='/user_logout.php'>Wyloguj</a>";
      }
  }

?>
