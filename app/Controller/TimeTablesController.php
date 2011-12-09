<?php
class TimeTablesController extends AppController {
  public $name = 'TimeTables';

  public function beforeFilter()
  {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();
    }
  }

  public function teacher_index(){
  }

  public function teacher_add(){
    $days_all = $this->TimeTable->findAllByClassId($this->currentUser('class_id'));
    $subjects = $this->TimeTable->SchoolClass->Subject->findAllByClassId($this->currentUser('class_id'));
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
    foreach($subjects as $value){
      $subject[$value['Subject']['id']] = $value['Subject']['name'];
    }
    $this->set('days', $days_week);
    $this->set('lessons', $subject);
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

}
?>
