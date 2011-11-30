<?php
  include_once('template/layout.class.php');
  layout::head_logged();
  layout::content();
    if(!empty($_SESSION['user']['login']) && $_SESSION['user']['account_type'] == 'teacher'){
      $class = new SchoolClass();
      $class -> id = $_SESSION['user']['class_id'];
      $subjects = $class -> subjects();
      echo '<ul>';
        foreach($subjects as $subject) {
          $id = $subject['id'];
          $name = $subject['name'];
          echo "<li><a href='marks.php?id=$id'>$name</a></li>";
        }
      echo '</ul>';

      if(!empty($_POST['id'])) {
        $teacher = new Teacher();
        $teacher -> id = $_SESSION['user']['id'];
        $students = $teacher -> students();
        $subject = new Subject();
        $subject -> id = $_POST['id'];
          echo '<table>
                  <td>
                    <tr></tr>
                    <tr></tr>
                    <tr></tr>';
                    $tr_count = 12 - $descriptions;
                    foreach($descriptions as $description) {
                      
                    }

                    foreach($descriptions as $description
                  </td>';
            foreach($students as $student) {
            }
          echo '</table>';
        $marks = $class -> subject_marks();
      }


    }

?>
