<?php
class StudentsController extends AppController {
  public $name = 'Students';

  function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();
      if ($this->action == 'teacher_create' || $this->action == 'teacher_index' || $this->action == 'teacher_delete' || $this->action == 'teacher_view' || $this->action == 'teacher_edit') {
        $this->isClassSet();
      }
    }
  }

  function teacher_create() {
    if ($this->request->is('post')) {
      $this->Student->create();
      if ($this->Student->save($this->request->data)) {
        $this->Session->setFlash ('Dodano nowego ucznia.', 'flash_success');
        $this->redirect($this->referer());
      }
    }
  }

  function teacher_index() {
    $this->set('students', $this->Student->findAllByClassIdAndStudent($this->currentUser('class_id'),'1',null,'Student.last_name ASC'));
    $this->set('province', $this->province);
    $this->set('school_id', CakeSession::read('Auth.User.school_id'));
  }
  
  function teacher_view(){
  
	$this->set('student', $this->Student->findAllByClassIdAndId($this->currentUser('class_id'),$this->params['pass'][0]));
	$this->set('user_id', $this->params['pass'][0]);
  }
  
  function teacher_delete() {
  
    if($this->Student->delete($this->params['pass'][0])){
		$this->redirect($this->referer());
	} else {
		$this->redirect($this->referer());
	}
	
  }

}
