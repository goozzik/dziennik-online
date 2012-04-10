<?php
class SemestersController extends AppController {

  public $name = 'Semesters';

  function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();
    }
  }

  function teacher_create() {
    if ($this->request->is('post')) {
      $this->Semester->create();
      if ($this->Semester->save($this->request->data)) {
        $this->Session->setFlash('Dodano nowy semestr.', 'flash_success');
        $this->redirect($this->referer());
      } else {
        $this->redirect($this->referer());
      }
    }
	}
  
}
?>