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
}
