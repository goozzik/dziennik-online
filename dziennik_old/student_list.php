<?php
  include_once('template/layout.class.php');
  layout::head_logged();
  layout::content();
    if(!empty($_POST['user_first_name'])){
      if(!empty($_SESSION['user']['login']) && $_SESSION['user']['account_type'] == 'teacher'){
        $student = new Student();
        $student -> school_id = $_SESSION['user']['school_id'];
        $student -> class_id = $_SESSION['user']['class_id'];
        $student -> first_name = $_POST['user_first_name'];
        $student -> last_name = $_POST['user_last_name'];
        $login_password = substr($student -> first_name, 0, 3) . substr($student -> last_name, 0, 3) . $_SESSION['user']['school_id'] . $_SESSION['user']['class_id'];
        $student -> login = $login_password;
        $student -> password = $login_password;

        $teacher = new Teacher();
        if($teacher -> create_student($student)){
          echo 'Udało się.';
        }
      } else {
        echo 'Brak dostępu.';
      }
    }

    if(!empty($_SESSION['user']['login']) && $_SESSION['user']['account_type'] == 'teacher'){
        $teacher = new Teacher();
        $teacher -> class_id = $_SESSION['user']['class_id'];
        $students = $teacher -> students();
        echo '<table class="student_list">
                <tr class="first_tr">
                  <td class="no"><b>Nr</b></td>
                  <td class="fn"><b>Imię</b></td>
                  <td class="ln"><b>Nazwisko</b></td>';
                  $i=1;
                  foreach($students as $student) {
                    layout::student_row($student, $i);
                    $i++;
                  }
        echo '</table>';
    }

    layout::teacher_new_student_form();
?>
