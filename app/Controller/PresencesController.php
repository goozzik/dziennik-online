<?php
class PresencesController extends AppController {
  public $name = 'Presences';

  function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();
      if ($this->action == 'teacher_create') {
        $this->isOwningClassFilter();
      }
    }
  }

  function teacher_index() {
    $this->set('students', $this->Presence->Student->findAllByClassIdAndStudent($this->currentUser('class_id'), '1'));
    $this->set('presence_model', $this->Presence);
    $this->set('week', $this->Presence->currentWeek());
  }

}
