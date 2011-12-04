<?php
class DescriptionsController extends AppController {
  public $name = 'Descriptions';

  function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();
      if ($this->action == 'teacher_create') {
        $this->isOwningSubjectFilter();
      }
    }
  }

  function isOwningSubjectFilter()
  {
    $this->loadModel('Subject');
    if (!$this->Subject->findByIdAndTeacherId($this->request->data['Description']['subject_id'], $this->currentUser('id'))) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  function teacher_create() {
    if ($this->request->is('post')) {
      $this->Description->create();
      if ($this->Description->save($this->request->data)) {
        $this->Session->setFlash('Dodano ocenę.', 'flash_success');
        $this->redirect($this->referer());
      }
    }
  }

}
