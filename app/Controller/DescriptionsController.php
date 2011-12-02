<?php
class DescriptionsController extends AppController {
  public $name = 'Descriptions';

  function beforeFilter() {
    $this->loadModel('Subject');
    $subject = $this->Subject->findByTeacherIdAndId($this->Session->read('Auth.User.class_id'), $this->request->data['Description']['subject_id']);
    if(!($this->Session->read('Auth.User.teacher') && empty($subject))) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  function create() {
    if ($this->request->is('post')) {
      $this->Description->create();
      if ($this->Description->save($this->request->data)) {
        $this->Session->setFlash('Dodano ocenę.', 'flash_success');
        $this->redirect($this->referer());
      }
    }
  }

}
