<?php
class SchoolClass extends AppModel {
  public $name = 'SchoolClass';
  public $useTable = 'classes';
  public $belongsTo = array('School', 'Teacher');
  public $hasMany = array('Student', 'Subject');
  public $actsAs = array('Containable');
}
