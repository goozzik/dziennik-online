<?php
class Subject extends AppModel {
  public $name = 'Subject';
  public $belongsTo = array('Teacher', 'School', 'SchoolClass' => array('foreignKey' => 'class_id'));
  public $hasMany = 'Description';
  public $actsAs = array('Containable');
}
