<?php
  include_once('user.class.php');

    class Teacher extends User {

      public function create_class($class){
        global $db_name;
        global $mysql;

        $mysql -> query("INSERT INTO $db_name.classes
          (user_id, name, school_id, yearbook)
          VALUES ('$class->user_id',
                  '$class->name',
                  '$class->school_id',
                  '$class->yearbook')");
        return 1;
      }

      public function reset_parent_password(){

      }

      public function generate_parrents_lists(){

      }


    }
?>
