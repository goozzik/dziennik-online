<?php
class Semester extends AppModel {
  public $name = 'Semester';
  public $belongsTo = array('SchoolClass' => array('foreignKey' => 'class_id'));
  public $actsAs = array('Containable');
  

  function beforeValidate() {
    App::import('CakeSession', 'AuthComponent');
	#$this->data['Semester']['class_id'] = $this -> params['pass'][0]; //class_id
	#$this->data['Semester']['semester'] = $this -> params['pass'][1]; //semester_id
	
	#print_r($this->request);
    
    return 1;
  }

 /*  function afterSave() {
    App::import('CakeSession', 'AuthComponent');
    $this->Teacher->id = CakeSession::read('Auth.User.id');
    $this->Teacher->set(array('class_id' => $this->id));
    $this->Teacher->save();
    CakeSession::write('Auth.User.class_id', $this->id); 
  } */
}
