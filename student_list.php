<?php
  if(!empty($_SESSION['user']['login']) && $_SESSION['user']['account_type'] == 'teacher'){
    $teacher = new Teacher();
    $teacher -> class_id = $_SESSION['user']['class_id'];
    $students = $teacher -> students();
    print_r($students);
    foreach($students as $student) {
      echo $student['id'];
    }
    echo $_SESSION['user']['class_id'];
  }
?>
