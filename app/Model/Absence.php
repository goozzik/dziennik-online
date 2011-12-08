<?php
class Absence extends AppModel {
  public $name = 'Absence';
  public $belongsTo = array('Student',
                            'SchoolClass' => array('foreignKey' => 'class_id'));

  function beforeValidate() {
    App::import('CakeSession', 'AuthComponent');
    $this->data['Absence']['class_id'] = CakeSession::read('Auth.User.class_id');
    return 1;
  }
 
  function currentMonday()
  {
    if (date('w') == 1) {
      $monday = new DateTime();
    } else {
      $monday = strtotime('previous monday');
    }
    return $monday;
  }

  function currentWeek()
  {
  	App::import('model','TimeTable');
    App::import('CakeSession', 'AuthComponent');
  	$TimeTable = new TimeTable();
    $class_id = CakeSession::read('Auth.User.class_id');
  	$monday = $this->currentMonday();
    for ($i=1; $i<=5; $i++) { 
      $week[$i] = array(
	      'day' => date('Y-m-d', $monday),
	      'time_table' => $TimeTable->findByWeekDayAndClassId(date('N', $monday), $class_id)
	    );
	    $monday += 86400;
    }
    return $week;
  }

  function normalizeType($type)
  {
    switch ($type) {
      case 'absence':
        return '|';
      case 'escape':
        return 'u';
      case 'exemption':
        return 'z';
      case 'justification':
        return '$';
    }
  }
}