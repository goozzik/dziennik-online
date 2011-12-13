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

  # Used by currentWeek(), return's date of first day of current week.
  function firstDay() {
    App::import('model','TimeTable');
    $TimeTable = new TimeTable();
    App::import('CakeSession', 'AuthComponent');
    $class_id = CakeSession::read('Auth.User.class_id');
    $first_day = $TimeTable->find('first', array('conditions' => array('TimeTable.class_id' => $class_id), 'order' => array('TimeTable.week_day ASC')));
    if ($first_day) {
      return strtotime('last ' . $this->intToDay($first_day['TimeTable']['week_day']));
    } else {
      return 0;
    }
  }

  function currentWeek($first_day = null) {
    App::import('model','TimeTable');
    $TimeTable = new TimeTable();
    App::import('CakeSession', 'AuthComponent');
    $class_id = CakeSession::read('Auth.User.class_id');
    if ($first_day) { $first_day = strtotime($first_day); }
    if ($first_day == null) { $first_day = $this->firstDay(); }
    $time_tables = $TimeTable->find('all', array('conditions' => array('TimeTable.class_id' => $class_id), 'order' => array('TimeTable.week_day ASC')));
    for ($i=0; $i<count($time_tables); $i++) {
      $week[$i] = array(
        'day' => date('Y-m-d', ($time_tables[$i]['TimeTable']['week_day'] - $time_tables['0']['TimeTable']['week_day']) * 86400 + $first_day),
        'time_table' => $time_tables[$i]
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
