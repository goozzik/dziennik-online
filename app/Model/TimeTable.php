<?php
class TimeTable extends User {
  public $name = 'TimeTable';
  public $belongsTo = array('SchoolClass' => array('foreignKey' => 'class_id'));
  public $hasMany = 'Lesson';
  public $actsAs = array('Containable'); 
}
