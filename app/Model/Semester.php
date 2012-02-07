<?php
class Semestr extends AppModel {
  public $name = 'Semester';
  public $belongsTo = array('SchoolClass' => array('foreignKey' => 'class_id'));
  public $actsAs = array('Containable');

  function beforeValidate() {
    App::import('CakeSession', 'AuthComponent');
    $this->data['SchoolClass']['school_id'] = CakeSession::read('Auth.User.school_id');
    $this->data['SchoolClass']['teacher_id'] = CakeSession::read('Auth.User.id');
    return 1;
  }

  function afterSave() {
    App::import('CakeSession', 'AuthComponent');
    $this->Teacher->id = CakeSession::read('Auth.User.id');
    $this->Teacher->set(array('class_id' => $this->id));
    $this->Teacher->save();
    CakeSession::write('Auth.User.class_id', $this->id); 
  }
}
