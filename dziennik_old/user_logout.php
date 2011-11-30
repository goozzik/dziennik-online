<?php
  include_once('template/layout.class.php');

    if(empty($_SESSION['user']['login'])){
      header('Location:index.php');
    } else {
      User::logout();
      header('Location:index.php');
    }

?>
