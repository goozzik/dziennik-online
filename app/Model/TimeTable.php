<?php
class TimeTable extends AppModel {
  public $name = 'TimeTable';
  public $belongsTo = array('SchoolClass' => array('foreignKey' => 'class_id'));
  public $hasMany = 'Lesson';
  public $actsAs = array('Containable'); 
  
  function beforeValidate() {
    App::import('CakeSession', 'AuthComponent');
    $this->data['TimeTable']['class_id'] = CakeSession::read('Auth.User.class_id');
  }
  
}
