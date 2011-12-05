<?php
class StudentsController extends AppController {
  public $name = 'Students';

  function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();
      if ($this->action == 'teacher_create' || $this->action == 'teacher_index') {
        $this->isClassSet();
      }
    }
  }

  function teacher_create() {
    if ($this->request->is('post')) {
      $this->Student->create();
      if ($this->Student->save($this->request->data)) {
        $this->Session->setFlash ('Dodano nowego ucznia.', 'flash_success');
        $this->redirect($this->referer());
      }
    }
  }

  function teacher_index() {
    $this->set('students', $this->Student->findAllByClassIdAndStudent($this->currentUser('class_id'), '1'));
  }

}
