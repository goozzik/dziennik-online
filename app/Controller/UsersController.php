<?php
class UsersController extends AppController {
  var $helpers = array ('Html','Form');
  var $name = 'Users';
  var $components = array('Auth');

  function beforeFilter() {
    parent::beforeFilter();
    $this->Auth->loginRedirect = array('controller' => 'pages', 'action' => 'home');
  }

  function index() {
      $this->set('users', $this->User->find('all'));
  }

  function login() {

  }

  function logout() {
    $this->redirect($this->Auth->logout());
  }

}
