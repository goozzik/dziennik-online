<?php
class TimeTablesController extends AppController {
  public $name = 'TimeTables';
  public $helpers = array('TimeTable');

  public function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();
      if ($this->action == 'teacher_index' || $this->action == 'teacher_add') {
        $this->isClassOwninigSubjects();
      }
    }
  }

  public function isClassOwninigSubjects() {
    $class = $this->TimeTable->SchoolClass->findById($this->currentUser('class_id'));
    if (empty($class['Subject'])) {
      $this->Session->setFlash('Najpierw musisz dodać przedmioty.', 'flash_error');
      $this->redirect('/teacher/subjects');
    }
  }

  public function teacher_index(){
    $this->set('time_tables', $this->TimeTable->findAllByClassId($this->currentUser('class_id'), array(), array('TimeTable.`week_day`' => 'asc')));
  }

  public function teacher_add(){
    $available_days = $this->TimeTable->findAllAvailableDaysByClassId($this->currentUser('class_id'));
    $subjects = $this->TimeTable->findSelectableSubjects($this->currentUser('class_id'));
    $this->set('days', $available_days);
    $this->set('lessons', $subjects);
  }

  public function teacher_create(){
    if ($this->request->is('post')) {
      $this->TimeTable->create();
      if ($this->TimeTable->save($this->request->data)) {
        $count = count($this->request->data['TimeTable']['Lesson']);
        for ($i=0; $i<$count; $i++) {
          if (empty($this->request->data['TimeTable']['Lesson'][$i]['subject_id'])) { continue; }
          $this->TimeTable->Lesson->create();
          $this->request->data['TimeTable']['Lesson'][$i]['time_table_id'] = $this->TimeTable->id;
          $this->request->data['TimeTable']['Lesson'][$i]['lesson_number'] = $i;
          $this->TimeTable->Lesson->save($this->request->data['TimeTable']['Lesson'][$i]);
        }
        $this->Session->setFlash('Dodano nowy dzień do planu lekcji.', 'flash_success');
        $this->redirect($this->referer());
      }
    }
  }

  public function teacher_delete() {
    if ($this->TimeTable->delete($this->params['pass'][0])) {
      $this->redirect($this->referer());
    } else {
      $this->redirect($this->referer());
    }
  }
}
?>
