<?php
class TimeTable extends AppModel {
  public $name = 'TimeTable';
  public $belongsTo = array('SchoolClass' => array('foreignKey' => 'class_id'));
  public $hasMany = 'Lesson';
  public $actsAs = array('Containable'); 
  
  function beforeValidate() {
  
  }
  
}
