<?php
App::import('Model','User');
App::import('Controller','Students');
class Student extends User {
  public $name = 'Student';
  public $belongsTo = array('Teacher', 'SchoolClass' => array('foreignKey' => 'class_id'));
  public $useTable = 'users';

  //public function provinces() {
   public $provinces =  array(
      0 => 'dolno¿l¿skie',
      1 => 'kujawsko-pomorskie',
      2 => 'lubelskie',
      3 => 'lubuskie',
      4 => '¿ódzkie',
      5 => 'ma¿opolskie',
      6 => 'mazowieckie',
      7 => 'opolskie',
      8 => 'podkarpackie',
      9 => 'podlaskie',
      10 => 'pomorskie',
      11 => '¿l¿skie',
      12 => '¿wi¿tokrzyskie',
      13 => 'warmi¿sko-mazurskie',
      14 => 'wielkopolskie',
      15 => 'zachodniopomorskie'
    );
	
	
  //}

  public function provinceName($province_id) {
    return $this->provinces[$province_id];
  }

  function beforeValidate() {
    App::import('CakeSession', 'AuthComponent');
    $this->data['Student']['school_id'] = CakeSession::read('Auth.User.school_id');
    $this->data['Student']['class_id'] = CakeSession::read('Auth.User.class_id');
    $this->data['Student']['teacher_id'] = CakeSession::read('Auth.User.id');
    $this->data['Student']['username'] = $this->data['Student']['first_name'] . $this->data['Student']['last_name'];
    $the_same_logins = 1;
    $Student = new Student();
    $check = $Student->find('first',array('conditions' => array('Student.username' => $this->data['Student']['username'])));
    while($this->data['Student']['username'] == $check['Student']['username']) {
      $this->data['Student']['username'] = $this->data['Student']['first_name'] . $this->data['Student']['last_name'].$the_same_logins;
      $check = $Student->find('first',array('conditions' => array('Student.username' => $this->data['Student']['username'])));
      $the_same_logins++;
    }
    #tu trzeba wymyœliæ inny sposób generowania has³a, mo¿e z ID?
    $this->data['Student']['password'] = AuthComponent::password($this->data['Student']['last_name']);
    $this->data['Student']['student'] = '1';
    return 1;
  }
}
