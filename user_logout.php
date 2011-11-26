<?php
  include_once('template/layout.class.php');

    if(empty($_SESSION['user']['login'])){
      layout::head();
      layout::content();
      echo "Musisz być zalogowany.";
      layout::div_end();
    } else {
      User::logout();
      header('Location:index.php');
    }

?>
