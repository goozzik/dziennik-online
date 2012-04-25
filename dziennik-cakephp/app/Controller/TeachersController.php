<?php
class TeachersController extends AppController {

  public $name = 'Teachers';

  function beforeFilter() {
    parent::beforeFilter();
    if ($this->action == 'teacher_edit') {
      $this->classAuth();
      $this->semesterAuth();
    }
  }

  private function classAuth() {
    if (!$this->Teacher->SchoolClass->findByIdAndTeacherId($this->request->data['Teacher']['class_id'], $this->currentUser('id'))) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  private function semesterAuth() {
    if (!$this->Teacher->Semester->findByIdAndTeacherId($this->request->data['Teacher']['semester_id'], $this->currentUser('id'))) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  /*function _refreshAuth($field = '', $value = '') {
    if (!empty($field) && !empty($value)) { 
      $this->Session->write($this->Auth->sessionKey .'.'. $field, $value);
    } else {
      if (isset($this->User)) {
        $this->Auth->login($this->User->read(false, $this->Auth->user('id')));
      } else {
        $this->Auth->login(ClassRegistry::init('User')->findById($this->Auth->user('id')));
      }
    }
  }*/

  function teacher_edit() {
    $this->Teacher->id = $this->currentUser('id');
    if ($this->Teacher->save($this->request->data)) {
      $this->Session->setFlash('Zapisano pomyślnie.', 'flash_success');
      $this->redirect('/teacher/school_classes');
    }
  }

}
?>
