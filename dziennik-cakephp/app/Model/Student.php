<?php
App::import('Model','User');
App::import('Controller','Students');
class Student extends User {
  public $name = 'Student';
  public $belongsTo = array('Teacher', 'SchoolClass' => array('foreignKey' => 'class_id'));
  public $useTable = 'users';
  
  public $provinces =  array(
      '--' => '-- wybierz --',
      0 => 'dolnośląskie',
      1 => 'kujawsko-pomorskie',
      2 => 'lubelskie',
      3 => 'lubuskie',
      4 => 'łódzkie',
      5 => 'małopolskie',
      6 => 'mazowieckie',
      7 => 'opolskie',
      8 => 'podkarpackie',
      9 => 'podlaskie',
      10 => 'pomorskie',
      11 => 'śląskie',
      12 => 'świętokrzyskie',
      13 => 'warmińsko-mazurskie',
      14 => 'wielkopolskie',
      15 => 'zachodniopomorskie'
    );
	
	  var $validate = array(
		'first_name' => array(
			'rule'=>array('minLength', 1), 
			'required' => true,
			'message'=>'Imie jest wymagane' ), 
		'last_name' => array(
			'rule'=>array('minLength', 1), 
			'required' => true,
			'message'=>'Nazwisko jest wymagane' ),
		'pesel' => array(
			'rule'=>array('numeric'), 
			'required' => true,
			'message'=>'Pesel jest wymagany' ),
		'niu' => array(
			'rule'=>array('minLength', 1), 
			'message'=>'Numer identyfikacyjny ucznia jest wymagany.' ),
		'street' => array(
			'rule'=>array('minLength', 1), 
			'message'=>'Ulica jest wymagana.' ),
		'city' => array(
			'rule'=>array('minLength', 1), 
			'message'=>'Miejscowość jest wymagana.' ),
		'zip_code' => array(
			'rule'=>array('minLength', 1), 
			'message'=>'Kod pocztowy jest wymagany.' ),
		'province' => array(
			'rule'=>array('numeric'),  
			'message'=>'Wybierz województwo.' ),
		'telephone' => array(
			'rule'=>'alphaNumeric', 
			'required' => false,
			'message'=>'Podaj numer telefonu składający się wyłącznie z cyfr')
	); 
  

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
	
	#tu trzeba wymyślić inny sposób generowania hasła, może z ID?
	$this->data['Student']['password'] = AuthComponent::password($this->data['Student']['last_name']);
	$this->data['Student']['student'] = '1';
	
	return 1;
	
	
  }
  

}
