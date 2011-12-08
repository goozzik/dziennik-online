<?php
class MarksController extends AppController {
  public $name = 'Marks';

  function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();
      if ($this->action == 'teacher_create' || $this->action == 'teacher_edit') {
        $this->isOwningClassFilter();
      }
    }
  }

  function isOwningClassFilter()
  {
    if($this->request->data['Mark']['class_id'] != $this->currentUser('class_id')) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  function teacher_create() {
    if ($this->request->is('post')) {
      $this->Mark->create();
      $this->Mark->save($this->request->data);
    }
    $this->autoRender = false;
  }

  function teacher_edit($id = null) {
    $this->Mark->id = $id;
    if ($this->request->is('post')) {
      $this->Mark->save($this->request->data);
    }
    $this->autoRender = false;
  }

}
