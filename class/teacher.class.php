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

      public function create_student($student){
        global $db_name;
        global $mysql;

        $mysql -> query("INSERT INTO $db_name.users
          (school_id, class_id, first_name, last_name, login, password, account_type)
          VALUES ('$student->school_id',
                  '$student->class_id',
                  '$student->first_name',
                  '$student->last_name',
                  '$student->login',
                  '$student->password',
                  '$student->account_type')");
        return 1;
      }

      public function reset_parent_password(){

      }

      public function generate_parrents_lists(){

      }


    }
?>
