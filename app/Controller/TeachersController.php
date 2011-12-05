<?php
class TeachersController extends AppController {
  public $name = 'Teachers';

  function beforeFilter() {
  	if ($this->params['teacher']) {
  	  $this->isTeacherFilter();	
  	  if ($this->action == 'teacher_edit') {
		$this->isOwningClassFilter();
  	  }
  	}
  }

  function _refreshAuth($field = '', $value = '') {
    if (!empty($field) && !empty($value)) { 
      $this->Session->write($this->Auth->sessionKey .'.'. $field, $value);
    } else {
      if (isset($this->User)) {
        $this->Auth->login($this->User->read(false, $this->Auth->user('id')));
      } else {
        $this->Auth->login(ClassRegistry::init('User')->findById($this->Auth->user('id')));
      }
    }
  }

  function isOwningClassFilter()
  {
  	$class = $this->Teacher->SchoolClass->findById($this->request->data['Teacher']['class_id']);
    if($class['SchoolClass']['teacher_id'] != $this->currentUser('id')) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  function teacher_edit() {
    $this->Teacher->id = $this->currentUser('id');
    if ($this->request->is('post')) {
      $this->Teacher->save($this->request->data);
      // This should also update other fields in session, TODO
      $this->Session->write('Auth.User.class_id', $this->request->data['Teacher']['class_id']); 
      $this->Session->setFlash('Zapisano pomyślnie.', 'flash_success');
      $this->redirect($this->referer());
    }
  }
}
