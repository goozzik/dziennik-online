<?php
class SubjectsController extends AppController {
  public $name = 'Subjects';

  function beforeFilter() {
    if ($this->params['teacher']) {
      parent::isTeacherFilter();
      if ($this->action == 'teacher_view') {
        $this->isOwningSubjectFilter();
      }
    }
  }

  function isOwningSubjectFilter()
  {
    if (!$this->Subject->findByIdAndTeacherId($this->params['id'], $this->currentUser('id'))) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  function teacher_view() {
    $this->set('descriptions', $this->Subject->Description->findAllBySubjectId($this->params['subject_id']));
    $this->set('students', $this->Subject->Teacher->Student->findAllByTeacherId($this->currentUser('id')));
    $this->set('mark_model', $this->Subject->Description->Mark);
  }
}
