<?php
class TeachersController extends AppController {
  public $name = 'Teachers';
  public $uses = 'User';

  function beforeFilter() {
    if(!$this->Session->read('Auth.User.teacher')) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  function students() {
    $this->set('students', $this->User->find('all',
      array('conditions' => array(
        'User.student' => true,
        'User.class_id' => $this->Session->read('Auth.User.class_id')
      ))
    ));
  }

}
