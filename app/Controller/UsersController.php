<?php
class UsersController extends AppController {
  public $name = 'Users';

  function beforeFilter() {
    #
  }

  function login() {
    if ($this->request->is('post')) {
      if ($this->Auth->login()) {
        $this->Session->setFlash('Zalogowano pomyślnie.');
        if ($this->currentUser('teacher') && !$this->currentUser('class_id')) {
          $this->redirect('/teacher/school_classes');
        }
        $this->redirect('/teacher/subjects');
      } else {
        $this->Session->setFlash('Twóje hasło/login jest niepoprawne.');
      }
    }
  }

  function logout() {
    $this->redirect($this->Auth->logout());
  }

}
