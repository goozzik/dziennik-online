<?php
class Semester extends AppModel {

  public $name = 'Semester';
  public $belongsTo = array('SchoolClass' => array('foreignKey' => 'class_id'));
  public $actsAs = array('Containable');
    
  public $validate = array(
  	'class_id' => array(
  		'rule' => 'validateClassPossession',
  		'message' => 'Ta klasa nie należy do ciebie.'));

  function beforeSave() {
    $count = $this->find('count', array('conditions' => array('Semester.class_id' => $this->data['Semester']['class_id'])));
  	$this->data['Semester']['semester'] = $count + 1; 
    return 1;
  }

  function validateClassPossession($class_id) {
    App::import('CakeSession', 'AuthComponent');
		return $this->SchoolClass->findByIdAndTeacherId($class_id, CakeSession::read('Auth.User.id'));
  }

}
?>