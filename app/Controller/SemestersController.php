<?php
class SemestersController extends AppController {

  public $name = 'Semesters';

  function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();
      if ($this->action == 'teacher_view') {
        $this->isOwningClassFilter();
      }
    }
  }

  function isOwningClassFilter() {
  }

  function teacher_create() {
    if ($this->request->is('post')) {
      $this->Semester->create();
      if ($this->Semester->save($this->request->data)) {
        $this->Session->setFlash('Dodano nowy semestr.', 'flash_success');
        $this->redirect($this->referer());
      }
    }
	}
  
}
?>