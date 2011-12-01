<?php
class School extends AppModel {
  public $name = 'School';
  public $hasOne = 'Admin';
  public $hasMany = array('Class', 'Teacher', 'Student' => array('foreignKey' => 'id'));
}
