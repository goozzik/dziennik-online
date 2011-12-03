<?php
class AppController extends Controller {
  public $helpers = array('Html','Form','Menu','Session');
  public $components = array('Auth','Session');

  function isTeacher() {
    if($this->Session->read('Auth.User.teacher')) {
      return 1;
    } else {
      return 0;
    }
  }

  function currentUser() {
    return $this->Session->read('Auth.User.id');
  }
}
