<?php
class AppController extends Controller {
  public $helpers = array('Html','Form','Menu','Session');
  public $components = array('Auth','Session');

  function currentUser($param) {
    return $this->Session->read('Auth.User.' . $param);
  }

  function isTeacherFilter() {
    if (!$this->currentUser('teacher')) {
	  $this->Session->setFlash('Brak dostępu.', 'flash_error');
	  $this->redirect($this->referer());
	}
  }
}
