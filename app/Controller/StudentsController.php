<?php
class StudentsController extends AppController {
  public $name = 'Students';

  function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();
      if ($this->action == 'teacher_create' || $this->action == 'teacher_index') {
        $this->isClassSet();
      }
    }
  }

  function isClassSet()
  {
    if (!$this->currentUser('class_id')) {
      $this->Session->setFlash('Najpierw ustaw swoją klasę. Możesz to zrobić <a href="/teacher/classes">tutaj</a>', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  function teacher_create() {
    if ($this->request->is('post')) {
      $this->Student->create();
      if ($this->Student->save($this->request->data)) {
        $this->Session->setFlash('Dodano nowego ucznia.', 'flash_success');
        $this->redirect(array('controller' => 'teachers', 'action' => 'students'));
      }
    }
  }

  function teacher_index() {
    $this->set('students', $this->Teacher->Student->findAllByClassId($this->current_user('class_id')));
  }

}
