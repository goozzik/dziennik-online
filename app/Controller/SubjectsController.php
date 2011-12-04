<?php
class SubjectsController extends AppController {
  public $name = 'Subjects';

  function beforeFilter() {
    if ($this->params['teacher']) {
      parent::isTeacherFilter();
      if ($this->action == 'teacher_view') {
        $this->isOwningSubjectFilter();
      }
      if ($this->action == 'teacher_index') {
        $this->isClassSet();
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

  function teacher_index() {
    $this->set('subjects', $this->Subject->findAllByClassId($this->currentUser('class_id')));
  }

  function teacher_view() {
    $this->set('subjects', $this->Subject->findAllByClassId($this->currentUser('class_id')));
    $this->set('descriptions', $this->Subject->Description->findAllBySubjectId($this->params['id']));
    $this->set('students', $this->Subject->Teacher->Student->findAllByClassIdAndStudent($this->currentUser('class_id'), '1'));
    $this->set('mark_model', $this->Subject->Description->Mark);
  }

}
