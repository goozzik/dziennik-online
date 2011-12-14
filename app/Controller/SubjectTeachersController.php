<?php
class SubjectTeachersController extends AppController {
  public $name = 'SubjectTeachers';

  function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();	
    }
  }

  function teacher_index() {
    $this->set('teachers', $this->SubjectTeacher->findAllByClassId($this->currentUser('class_id')));
  }
}

