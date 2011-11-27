<?php
  include_once('template/layout.class.php');

    if(!empty($_POST['class_name'])){
      if(!empty($_SESSION['user']['login']) && $_SESSION['user']['account_type'] == 'teacher'){
        $class = new Class();
        $class -> user_id = $_SESSION['user']['id'];
        $class -> name = $_POST['class_name'];
        $class -> school_id = $_SESSION['user']['school_id'];
        $class -> yearbook = $_POST['class_yearbook'];

        $teacher = new Teacher();
        $teacher -> create_class($class);
      } else {
        echo 'Brak dostępu.';
      }
    } else {
      layout::head();
      layout::content();
      layout::teacher_new_class_form();
      layout::div_end();
    }

?>

