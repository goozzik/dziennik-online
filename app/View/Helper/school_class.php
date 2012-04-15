<?php
class SchoolClassHelper extends AppHelper {

  public $helpers = array('Form');

  function activateSemesterButton($class_id, $semester_id) {
    echo $this->Form->create('Teacher', array('teacher' => true, 'controller' => 'teachers', 'action' => 'edit'));
    echo $this->Form->input('class_id', array('type' => 'hidden', 'value' => $class_id));
    echo $this->Form->input('semester_id', array('type' => 'hidden', 'value' => $semester_id));
    echo $this->Form->end('Ustaw jako aktywny');
  }

}
?>
