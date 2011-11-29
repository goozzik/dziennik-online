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

      public function students(){
        global $db_name;
        global $mysql;
        $query = $mysql -> query("SELECT * FROM `$db_name`.`users` WHERE `class_id` = '$this->class_id'");
        $i=0;
        while($query -> fetch_assoc()){
        
          $result_users[$i]['user_id'] = $result['user_id'];
          $i++; 
        }

        return $result_users;
      }

      public function reset_parent_password(){

      }

      public function generate_parrents_lists(){

      }


    }
?>
