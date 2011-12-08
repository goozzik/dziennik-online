<?php
class AbsencesController extends AppController {
  public $name = 'Absences';

  function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();
      if ($this->action == 'teacher_create' || $this->action == 'teacher_edit') {
        $this->isOwningStudentFilter();
      }
    }
  }

  function isOwningStudentFilter()
  {
    if ($this->Absence->Student->findByClassIdAndId(currentUser('class_id'), $this->request->data['Absence']['student_id']) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  function teacher_create() {
    if ($this->request->is('post')) {
      $this->Absence->create();
      $this->Absence->save($this->request->data);
    }
    $this->autoRender = false;
  }

  function teacher_edit($id = null) {
    $this->Absence->id = $id;
    if ($this->request->is('post')) {
      $this->Absence->save($this->request->data);
    }
    $this->autoRender = false;
  }

  function teacher_index() {
    $this->set('students', $this->Absence->Student->findAllByClassIdAndStudent($this->currentUser('class_id'), '1'));
    $this->set('week', $this->Absence->currentWeek());
    $this->set('Absence', $this->Absence);
  }

}
