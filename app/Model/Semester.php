<?php
class Semester extends AppModel {

  public $name = 'Semester';
  public $belongsTo = array('SchoolClass' => array('foreignKey' => 'class_id'));
  public $actsAs = array('Containable');
    
  function beforeValidate() {
    App::import('CakeSession', 'AuthComponent');
    $count = $this->find('count', array('conditions' => array('Semester.class_id' => $this->data['Semester']['class_id'])));
  	$this->data['Semester']['semester'] = $count + 1; 
    return 1;
  }

}
?>