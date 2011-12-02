<?php
class Mark extends AppModel {
  public $name = 'Mark';
  public $belongsTo = array('Student',
                            'SchoolClass' => array('foreignKey' => 'class_id'),
                            'Subject',
                            'Description');
}
