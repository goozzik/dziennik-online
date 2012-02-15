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

  function intToDay($int) {
    switch ($int) {
      case 1: return 'Monday';
      case 2: return 'Tuesday';
      case 3: return 'Wednesday';
      case 4: return 'Thursday';
      case 5: return 'Friday';
      case 6: return 'Saturday';
      case 0: return 'Sunday';
    }
  }

  function currentMonth() {
    App::import('model','TimeTable');
    $TimeTable = new TimeTable();
    App::import('CakeSession', 'AuthComponent');
    $class_id = CakeSession::read('Auth.User.class_id');
    $current_date = getdate();
    $first_monday = date('Y-m-d', strtotime('First monday of this month'));
    for ($i=0; $i<4; $i++) {
      $week[$i] = array(
        'date' => date('Y-m-d', 604800 * $i + strtotime($first_monday)),
      );
    }
    return $week;
  }

  function PreviousWeekFirstDay($current_week) {
    return date('Y-m-d', strtotime($current_week['0']['day']) - 7 * 86400);
  }

  function NextWeekFirstDay($current_week) {
    return date('Y-m-d', strtotime($current_week['0']['day']) + 7 * 86400);
  }
}
