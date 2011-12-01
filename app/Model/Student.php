<?php
App::import('Model','User');
class Student extends User {
  public $name = 'Student';
  public $belongsTo = array('Teacher', 'Class');
  public $useTable = 'users';

  function beforeValidate() {
    App::import('CakeSession', 'AuthComponent');
    $this->data['Student']['school_id'] = CakeSession::read('Auth.User.school_id');
    $this->data['Student']['class_id'] = CakeSession::read('Auth.User.class_id');
    $this->data['Student']['teacher_id'] = CakeSession::read('Auth.User.id');
    $this->data['Student']['username'] = $this->data['Student']['first_name'] . $this->data['Student']['last_name'];
    $this->data['Student']['password'] = AuthComponent::password($this->data['Student']['last_name']);
    $this->data['Student']['student'] = '1';
    return 1;
  }
}
