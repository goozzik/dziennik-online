<?php
App::import('Model','User');
class Teacher extends User {

  public $name = 'Teacher';
  public $hasMany = array(
    'Student' => array('conditions' => array('Student.student' => '1')),
    'SchoolClass', 'Subject', 'Semester');
  public $useTable = 'users';
  public $actsAs = array('Containable');

  function afterSave($created) {
    if (!$created) {
      App::import('CakeSession', 'AuthComponent');
      CakeSession::write('Auth.User.class_id', $this->data['Teacher']['class_id']);
      CakeSession::write('Auth.User.semester_id', $this->data['Teacher']['semester_id']);
    }
  }

}
?>
