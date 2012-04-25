<?php
class SubjectTeacher extends AppModel {
  public $name = 'SubjectTeacher';
  public $useTable = 'teachers';
  public $belongsTo = array('SchoolClass' => array('foreignKey' => 'class_id'), 'Subject');
  public function beforeValidate() {
    App::import('CakeSession', 'AuthComponent');
    $this->data['SubjectTeacher']['class_id'] = CakeSession::read('Auth.User.class_id');
    return 1;
  }
  
    var $validate = array(
    'first_name' => array(
        'rule'=>array('minLength', 1), 
		'required' => true,
        'message'=>'Imie jest wymagane' ), 
	'last_name' => array(
        'rule'=>array('minLength', 1), 
		'required' => true,
        'message'=>'Nazwisko jest wymagane' ),
    'mail' => array(
        'rule'=>'email', 
        'message'=>'Podaj poprawny adres e-mail' ),
	'subject_id' => array(
        'rule'=>array('numeric'), 
		'required' => true,
        'message'=>'Podaj poprawny adres e-mail' ),
    'telephone' => array(
        'rule'=>'alphaNumeric', 
		'required' => false,
        'message'=>'Podaj numer telefonu składający się wyłącznie z cyfr')
); 
}
