<?php
class SchoolClass extends AppModel {

  public $name = 'SchoolClass';
  public $useTable = 'classes';
  public $belongsTo = array('School', 'Teacher');
  public $hasMany = array('Student', 'Subject', 'SubjectTeacher', 'Semester', 'TimeTable');
  public $actsAs = array('Containable');

  function beforeValidate() {
    App::import('CakeSession', 'AuthComponent');
    $this->data['SchoolClass']['school_id'] = CakeSession::read('Auth.User.school_id');
    $this->data['SchoolClass']['teacher_id'] = CakeSession::read('Auth.User.id');
    return 1;
  }

  function afterSave($created) {
    if ($created) {
      App::import('CakeSession', 'AuthComponent');
      $this->Semester->create();
      $this->Semester->set(array('class_id' => $this->id, 'semester' => 1));
      $this->Semester->save();
      $this->Teacher->id = CakeSession::read('Auth.User.id');
      $this->Teacher->set(array('class_id' => $this->id, 'semester_id' => $this->Semester->id));
      $this->Teacher->save();
      CakeSession::write('Auth.User.class_id', $this->id);
      CakeSession::write('Auth.User.semester_id', $this->Semester->id);
    }
  }

}
?>
