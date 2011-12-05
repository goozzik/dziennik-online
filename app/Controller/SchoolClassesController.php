<?php
class SchoolClassesController extends AppController {
  public $name = 'SchoolClasses';

  function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();
      if ($this->action == 'teacher_view') {
        $this->isOwningClassFilter();
      }
    }
  }

  function isOwningClassFilter()
  {
    $class = $this->SchoolClass->findById($this->params['id']);
    if($class['SchoolClass']['teacher_id'] != $this->currentUser('id')) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  function teacher_create() {
    if ($this->request->is('post')) {
      $this->SchoolClass->create();
      if ($this->SchoolClass->save($this->request->data)) {
        $this->Session->setFlash('Dodano nową klasę.', 'flash_success');
        $this->redirect(array('controller' => 'school_classes', 'action' => 'index'));
      }
    }
  }

  function teacher_index() {
    $this->set('classes', $this->SchoolClass->findAllByTeacherId($this->currentUser('id')));
  }

  function teacher_view() {
    $this->set('class', $this->SchoolClass->findById($this->params['id']));
  }
}