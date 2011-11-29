<?php
  session_start();
  include_once('class/user.class.php');
  include_once('class/teacher.class.php');
  include_once('class/class.class.php');
  include_once('class/admin.class.php');
  include_once('class/mysql.class.php');

  include_once('functions/text.inc.php');

  $mysql = new Mysql();
  $mysql -> connect();

  class layout {

      static public function head_logged(){
	  
        echo '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
		<head>
		
                <link rel="stylesheet" type="text/css" href="css/default.css">
                <link rel="stylesheet" type="text/css" href="css/menu.css">
                <script src="js/jquery.js" type="text/javascript"></script>
                <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
              </head>';
			  
		if($_SESSION['user']['account_type'] == 'teacher'){
		
			echo '
				<div id="menu">
					<ul>
						<li class="first"><a href="">Uczniowie</a></li><li><a href="">Oceny</a></li><li><a href="">Dokumenty</a></li><li><a href="">Plan lekcji</a></li><li><a href="">Nauczyciele</a></li><li><a href="">Raporty</a></li><li><a href="">Frekwencja</a></li><li><a href="">Ustawienia</a></li><li><a href="">Ustawienia klasy</a></li><li class="last"><a href="">Wyloguj</a></li>
					</ul>
				</div>';
				
		} elseif($_SESSION['user']['account_type'] == 'student'){
			echo '
				<div id="menu">
					<ul>
						<li class="first"><a href="">Uczniowie</a></li><li><a href="">Oceny</a></li><li><a href="">Dokumenty</a></li><li><a href="">Plan lekcji</a></li><li><a href="">Nauczyciele</a></li><li><a href="">Raporty</a></li><li><a href="">Frekwencja</a></li><li><a href="">Ustawienia</a></li><li class="last"><a href="user_logout.php">Wyloguj</a></li>
					</ul>
				</div>';
		}
		
      }
	  
	  static public function head(){
	  
        echo '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
		<head>
		
                <link rel="stylesheet" type="text/css" href="css/default.css">
                <script src="js/jquery.js" type="text/javascript"></script>
                <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
              </head>';
		
      }

      static public function content(){
        echo '<div id="content">';
      }

      static public function div_end(){
        echo '</div>';
      }

      static public function header_parrent(){
        echo 'HTML CODE';
      }

      static public function user_login_form(){
        echo '<form action="#" method="post">
                <div>
                  <label>Login</label>
                  <input type="text" name="user_login">
                </div>
                <div>
                  <label>Hasżo</label>
                  <input type="text" name="user_password">
                </div>
                <div>
                  <input type="submit" value="Zaloguj">
                </div>
              </form>';
      }

      static public function sign_in_link(){
        echo '<a href="user_login.php">Zaloguj</a>';
      }

      static public function sign_out_link(){
       # echo '<a href="user_logout.php">Wyloguj</a>';
      }

      static public function admin_new_teacher_form(){
        echo '<form action="#" method="post">
                <div>
                  <label>Login</label>
                  <input type="text" name="user_login">
                </div>
                <div>
                  <label>Hasło</label>
                  <input type="text" name="user_password">
                </div>
                <div>
                  <label>Imię</label>
                  <input type="text" name="user_first_name">
                </div>
                <div>
                  <label>Nazwisko</label>
                  <input type="text" name="user_last_name">
                </div>
                <div>
                  <label>E-mail</label>
                  <input type="text" name="user_mail">
                </div>
                <div>
                  <input type="submit" value="Utwórz">
                </div>
              </form>';
      }

      static public function teacher_new_class_form(){
        echo '<form action="#" method="post">
                <div>
                  <label>Nazwa (np. G)</label>
                  <input type="text" name="class_name">
                </div>
                <div>
                  <label>Rocznik</label>
                  <input type="text" name="class_yearbook">
                </div>
                <div>
                  <input type="submit" value="Utwórz">
                </div>
              </form>';
      }
  }

?>
