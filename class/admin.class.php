<?php
  include_once('user.class.php');
  class Admin extends User {

    public function create_teacher($teacher){
      global $db_name;
      global $mysql;

      $teacher -> password = md5($this -> password);
      $teacher -> account_type = 'teacher';

      $mysql -> query("INSERT INTO '$db_name'.'users'
        (login, password, first_name, last_name, mail, account_type)
        VALUES ('$teacher->login',
                '$teacher->password',
                '$teacher->first_name',
                '$teacher->last_name',
                '$teacher->mail',
                '$teacher->account_type)");
    }

  }
?>
