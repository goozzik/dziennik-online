<?php
  include_once('template/layout.class.php');

    if(!empty($_POST['user_first_name'])){
      if(!empty($_SESSION['user']['login']) && $_SESSION['user']['account_type'] == 'teacher'){
        $student = new Student();
        $student -> school_id = $_SESSION['user']['school_id'];
        $student -> first_name = $_POST['user_first_name'];
        $student -> last_name = $_POST['user_last_name'];
        $login_password = substr($student -> first_name, 0, 3) . substr($student -> last_name, 0, 3) . $_SESSION['user']['school_id'] . $_SESSION['user']['class_id'];
        $student -> login = $login_password;
        $student -> password = $login_password;
        $student -> account_type = 'student';

        $teacher = new Teacher();
        if($teacher -> create_student($student)){
          echo 'Udało się.';
        }
      } else {
        echo 'Brak dostępu.';
      }
    } else {
      layout::head_logged();
      layout::content();
      layout::teacher_new_student_form();
      layout::div_end();
    }

?>
