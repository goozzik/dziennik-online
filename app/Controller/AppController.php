<?php
class AppController extends Controller {

  public $helpers = array('Html', 'Form', 'Menu', 'Footer', 'Session');
  public $components = array('Auth', 'Session');

  function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();
    }
  } 

  function currentUser($param) {
    return $this->Session->read('Auth.User.' . $param);
  }

  function isTeacherFilter() {
    if (!$this->currentUser('teacher')) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  function isClassSet() {
    if (!$this->currentUser('class_id')) {
      $this->Session->setFlash('Najpierw ustaw swoją klasę. Możesz to zrobić tutaj', 'flash_error');
      $this->redirect('/teacher/school_classes');
    }
  }

}
?>