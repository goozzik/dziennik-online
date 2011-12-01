<?php
class UsersController extends AppController {
  public $name = 'Users';

  function beforeFilter() {
    #
  }

  function login() {
    if ($this->request->is('post')) {
      if ($this->Auth->login()) {
          $this->redirect($this->Auth->redirect());
      } else {
          $this->Session->setFlash('Your username/password
combination was incorrect');
      }
    }
  }

  function logout() {
    $this->redirect($this->Auth->logout());
  }

}
