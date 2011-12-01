<?php
class StudentsController extends AppController {
  public $name = 'Students';

  function beforeFilter() {
    #
  }

  function create() {
    if ($this->request->is('post')) {
      $this->Student->create();
      if ($this->Student->save($this->request->data)) {
        $this->Session->setFlash('Dodano nowego ucznia.', 'flash_success');
        $this->redirect(array('controller' => 'teachers', 'action' => 'students'));
      }
    }
  }

}
