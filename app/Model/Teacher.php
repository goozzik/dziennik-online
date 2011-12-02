<?php
App::import('Model','User');
class Teacher extends User {
  public $name = 'Teacher';
  public $hasMany = array(
    'Student' => array('conditions' => array('Student.student' => '1')),
    'SchoolClass', 'Subject');
  public $useTable = 'users';
  public $actsAs = array('Containable');
}
