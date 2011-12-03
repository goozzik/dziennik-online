<?php
class SchoolClassesController extends AppController {
  public $name = 'SchoolClasses';

  function beforeFilter() {
    if(!$this->isTeacher()) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  function create() {
    if ($this->request->is('post')) {
      $this->SchoolClass->create();
      if ($this->SchoolClass->save($this->request->data)) {
        $this->Session->setFlash('Dodano nową klasę.', 'flash_success');
        $this->redirect(array('controller' => 'teachers', 'action' => 'classes'));
      }
    }
  }

}
