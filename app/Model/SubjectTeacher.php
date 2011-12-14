<?php
class SubjectTeacher extends AppModel {
  public $name = 'SubjectTeacher';
  public $useTable = 'teachers';
  public $belongsTo = array('SchoolClass' => array('foreignKey' => 'class_id'), 'Subject');
}
