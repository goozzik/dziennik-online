<?php
class TeachersController extends AppController {
  public $name = 'Teachers';

  function beforeFilter() {
    if(!$this->Session->read('Auth.User.teacher')) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  function classes() {
    $this->set('classes', $this->Teacher->SchoolClass->findAllByTeacherId($this->currentUser()));
  }

}
