<?php
class AbsencesController extends AppController {
  public $name = 'Absences';

  function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();
      if ($this->action == 'teacher_create') {
        $this->isOwningClassFilter();
      }
    }
  }

  function teacher_index() {
    $this->set('students', $this->Absence->Student->findAllByClassIdAndStudent($this->currentUser('class_id'), '1'));
    $this->set('week', $this->Absence->currentWeek());
    $this->set('Absence', $this->Absence);
  }

}
