<?php
App::import('Model','User');
App::import('Controller','Students');
class Student extends User {
  public $name = 'Student';
  public $belongsTo = array('Teacher', 'SchoolClass' => array('foreignKey' => 'class_id'));
  public $useTable = 'users';

  function beforeValidate() {
    App::import('CakeSession', 'AuthComponent');
    $this->data['Student']['school_id'] = CakeSession::read('Auth.User.school_id');
    $this->data['Student']['class_id'] = CakeSession::read('Auth.User.class_id');
    $this->data['Student']['teacher_id'] = CakeSession::read('Auth.User.id');
	$this->data['Student']['username'] = $this->data['Student']['first_name'] . $this->data['Student']['last_name'];
	$the_same_logins = 1;
	$Student = new Student();
	$check = $Student->find('first',array('conditions' => array('Student.username' => $this->data['Student']['username'])));
	
	while($this->data['Student']['username'] == $check['Student']['username']){
		
		$this->data['Student']['username'] = $this->data['Student']['first_name'] . $this->data['Student']['last_name'].$the_same_logins;
		$check = $Student->find('first',array('conditions' => array('Student.username' => $this->data['Student']['username'])));
		$the_same_logins++;
	}
   
    $this->data['Student']['password'] = AuthComponent::password($this->data['Student']['last_name']);#tu trzeba wymyœliæ inny sposób generowania has³a, mo¿e z ID?
    $this->data['Student']['student'] = '1';
    return 1;
  }
}
