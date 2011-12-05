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
      $this->Session->setFlash('Utworzono.', 'flash_error');
      $this->redirect($this->referer());
    }
  }
}
