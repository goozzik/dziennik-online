<?php
class SchoolClass extends AppModel {
  public $name = 'Class';
  public $useTable = 'classes';
  public $belongsTo = array('School', 'Teacher');
  public $hasMany = array('Student' => array('foreignKey' => 'id'));
}
