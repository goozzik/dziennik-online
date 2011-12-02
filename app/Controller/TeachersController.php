<?php
class TeachersController extends AppController {
  public $name = 'Teachers';

  function beforeFilter() {
    if(!$this->Session->read('Auth.User.teacher')) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  function students() {
    $this->set('students', $this->Teacher->Student->findAllByTeacherId($this->Session->read('Auth.User.id')));
  }

  function subjects() {
    $this->set('subjects', $this->Teacher->SchoolClass->Subject->findAllByClassId($this->Session->read('Auth.User.class_id')));
  }

}
