<?php
class School extends AppModel {
  public $name = 'School';
  public $hasOne = 'Admin';
  public $hasMany = array('SchoolClass', 'Teacher', 'Student' => array('foreignKey' => 'id'));
}
