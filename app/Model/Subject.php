<?php
class Subject extends AppModel {
  public $name = 'Subject';
  public $belongsTo = array('School', 'SchoolClass' => array('foreignKey' => 'class_id'));
}
