<?php
class AbsencesController extends AppController {
  public $name = 'Absences';

  function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();
      if ($this->action == 'teacher_create' || $this->action == 'teacher_edit') {
        $this->isOwningStudentFilter();
      }
      if ($this->action == 'teacher_index') {
        //$this->isTimeTableSetFilter();
        true;
      }
    }
  }

  function isTimeTableSetFilter() {
    if (!$this->Absence->firstDay()) {
      $this->Session->setFlash('Najpierw musisz uzupełnić plan lekcji. Możesz to zrobić tutaj.', 'flash_error');
      $this->redirect('/teacher/time_tables/add');
    }
  }

  function isOwningStudentFilter()
  {
    if (!$this->Absence->Student->findByClassIdAndId($this->currentUser('class_id'), $this->request->data['Absence']['student_id'])) {
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
    $month = $this->Absence->currentMonth();
    $this->set('month', $month);
    $this->set('Absence', $this->Absence);
  }

  function teacher_view_week() {
    $this->set('students', $this->Absence->Student->findAllByClassIdAndStudent($this->currentUser('class_id'), '1'));
    $week = $this->Absence->currentWeek($this->params['date']);
    $this->set('week', $week);
    $this->set('Absence', $this->Absence);
    $this->set('last_week', $this->Absence->PreviousWeekFirstDay($week));
    $this->set('next_week', $this->Absence->NextWeekFirstDay($week));
  }

}
