<?php
class MarkSemesters extends AppModel {
  public $name = 'MarkSemesters';
  #public $useTable = 'marks_semesters';
  public $belongsTo = array('Student',
                            'SchoolClass' => array('foreignKey' => 'class_id'),
                            'Subject',
                            'Semester');
}
