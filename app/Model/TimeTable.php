<?php
class TimeTable extends AppModel {
  public $name = 'TimeTable';
  public $belongsTo = array('SchoolClass' => array('foreignKey' => 'class_id'));
  public $hasMany = array('Lesson' => array('dependent' => true));
  public $actsAs = array('Containable'); 

  function beforeValidate() {
    App::import('CakeSession', 'AuthComponent');
    $this->data['TimeTable']['class_id'] = CakeSession::read('Auth.User.class_id');
  }

  function findAllAvailableDaysByClassId($class_id) {
    $week = array(
      1 => 'Poniedziałek',
      2 => 'Wtorek',
      3 => 'Środa',
      4 => 'Czwartek',
      5 => 'Piątek',
      6 => 'Sobota',
      7 => 'Niedziela'
    );
    $days = $this->findAllByClassId($class_id);
    foreach($days as $day){
      unset($week[$day['TimeTable']['week_day']]);
    }
    return $week;
  }

  function findSelectableSubjects($class_id) {
    $_subjects = $this->SchoolClass->Subject->findAllByClassId($class_id);
    foreach ($_subjects as $value) {
      $subjects[$value['Subject']['id']] = $value['Subject']['name'];
    }
    return $subjects;
  }
}
