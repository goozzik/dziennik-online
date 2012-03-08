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

  function teacher_update() {
    if ($this->request->is('post')) {
      $absence = $this->Absence->findByDateAndStudentId($this->request->data['Absence']['date'], $this->request->data['Absence']['student_id']);
      if ($absence) {
        $this->Absence->id = $absence['Absence']['id'];
      } else {
        $this->Absence->create();
      }
      $this->Absence->save($this->request->data);
    }
    $this->autoRender = false;
  }

  function teacher_index() {
    if ($this->params['date']) {
      $month = $this->Absence->getMonth($this->params['date']);
    } else {
      $month = $this->Absence->currentMonth();
    }
    $students = $this->Absence->Student->findAllByClassIdAndStudent($this->currentUser('class_id'), '1');
    $this->Absence->AbsenceReport->calculateFrequencies($students, $month);
    $this->set('students', $students);
    $this->set('month', $month);
    $this->set('Absence', $this->Absence);
    $this->set('previous_month', date('Y-m-d', strtotime('previous month first monday of ' . $month[0]['date'])));
    $this->set('next_month', date('Y-m-d', strtotime('next month first monday of ' . $month[0]['date'])));
  }
}
