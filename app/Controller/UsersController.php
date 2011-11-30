<?php
class UsersController extends AppController {
  var $helpers = array ('Html','Form');
  var $name = 'Users';
  var $components = array('Auth');

  function beforeFilter() {
    parent::beforeFilter();
    $this->Auth->allow('login'); 
  }

  function index() {
      $this->set('users', $this->User->find('all'));
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
