<?php
  include_once('template/layout.class.php');

    if(!empty($_POST['user_login'])){
      if(!empty($_SESSION['user']['login']) || $_SESSION['user']['account_type'] == 'admin'){
        $teacher = new Teacher();
        $teacher -> login = $_POST['user_login'];
        $teacher -> password = $_POST['user_password'];
        $teacher -> first_name = $_POST['user_login'];
        $teacher -> last_name = $_POST['user_last_name'];
        $teacher -> mail = $_POST['user_mail'];

        $admin = new Admin();
        $admin -> create_teacher($teacher);
      } else {
        echo 'Brak dostępu.';
      }
    } else {
      layout::head_logged();
      layout::content();
      layout::admin_new_teacher_form();
      layout::div_end();
    }

?>
