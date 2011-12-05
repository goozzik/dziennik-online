<?php
class Subject extends AppModel {
  public $name = 'Subject';
  public $belongsTo = array('Teacher', 'School', 'SchoolClass' => array('foreignKey' => 'class_id'));
  public $hasMany = 'Description';
  public $actsAs = array('Containable');

  function beforeValidate() {
    App::import('CakeSession', 'AuthComponent');
    $this->data['Subject']['school_id'] = CakeSession::read('Auth.User.school_id');
    $this->data['Subject']['class_id'] = CakeSession::read('Auth.User.class_id');
    $this->data['Subject']['teacher_id'] = CakeSession::read('Auth.User.id');
    return 1;
  }
}
