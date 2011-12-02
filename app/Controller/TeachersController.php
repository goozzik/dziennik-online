<?php
class TeachersController extends AppController {
  public $name = 'Teachers';

  function beforeFilter() {
    if(!$this->Session->read('Auth.User.teacher')) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  function students() {
    $this->set('students', $this->Teacher->Student->findAllByTeacherId($this->Session->read('Auth.User.id')));
  }

  function subjects() {
    $this->set('subjects', $this->Teacher->SchoolClass->Subject->findAllByClassId($this->Session->read('Auth.User.class_id')));
  }

  function subject() {
    $subject = $this->Teacher->SchoolClass->Subject->findByTeacherId($this->Session->read('Auth.User.id'));
    if($subject['Subject']['id'] == $this->params['subject_id']) {
      $description_model = $this->Teacher->SchoolClass->Subject->Description;
      $this->set('descriptions', $description_model->findAllBySubjectId($this->params['subject_id']));
      $this->set('students', $this->Teacher->Student->findAllByTeacherId($this->Session->read('Auth.User.id')));
      $this->set('mark_model', $description_model->Mark);
    } else {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

}
