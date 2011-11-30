<?php
  class SchoolClass {
    var $user_id;
    var $school_id;
    var $yearbook;
    var $name;
    var $id;

    public function subjects(){
      global $db_name;
      global $mysql;

      $query = $mysql -> query("SELECT * FROM `$db_name`.`subjects` WHERE `class_id` = '$this->id'");
      $result_subjectes = array();
      $i = 0;
      while($result = $query -> fetch_assoc()){
        $result_subjects[$i]['name'] = $result['name'];
        $result_subjects[$i]['id'] = $result['id'];
      $i++;
      }
      sort($result_subjects);
      return $result_subjects;
    }
  }
?>
