<?php
class TimeTablesController extends AppController {
  public $name = 'TimeTables';
  public $helpers = array('TimeTable');

  public function beforeFilter()
  {
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
    $this->set('time_tables', $this->TimeTable->findAllByClassId($this->currentUser('class_id'),array(), array('TimeTable.`week_day`' => 'asc')));
  }

  public function teacher_add(){
    $days_all = $this->TimeTable->findAllByClassId($this->currentUser('class_id'));
    $_subjects = $this->TimeTable->SchoolClass->Subject->findAllByClassId($this->currentUser('class_id'));
    $days_week = array(
      1 => 'Poniedziałek',
      2 => 'Wtorek',
      3 => 'Środa',
      4 => 'Czwartek',
      5 => 'Piątek',
      6 => 'Sobota',
      7 => 'Niedziela'
    );
    foreach($days_all as $day){
      unset($days_week[$day['TimeTable']['week_day']]);
    }
    foreach($_subjects as $value){
      $subjects[$value['Subject']['id']] = $value['Subject']['name'];
    }
    $this->set('days', $days_week);
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
  
   function teacher_delete()
   {

    if($this->TimeTable->delete($this->params['pass'][0])){
		$this->redirect($this->referer());
	} else {
		$this->redirect($this->referer());
	}

   }

}
?>
