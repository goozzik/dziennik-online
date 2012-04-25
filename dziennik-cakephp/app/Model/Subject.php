<?php
class Subject extends AppModel {
  public $name = 'Subject';
  public $belongsTo = array('Teacher', 'School', 'SchoolClass' => array('foreignKey' => 'class_id'));
  public $hasMany = array('Description','MarkSemesters');
  public $hasOne = 'SubjectTeacher';
  public $actsAs = array('Containable');

  function beforeValidate() {
    App::import('CakeSession', 'AuthComponent');
    $this->data['Subject']['school_id'] = CakeSession::read('Auth.User.school_id');
    $this->data['Subject']['class_id'] = CakeSession::read('Auth.User.class_id');
    $this->data['Subject']['teacher_id'] = CakeSession::read('Auth.User.id');
    return 1;
  }

  function findAllByClassIdAndNoTeacher($class_id) {
    $_subjects = $this->SubjectTeacher->Subject->findAllByClassId($class_id);
    $subjects = array();
    foreach ($_subjects as $subject) {
      if (!$subject['SubjectTeacher']['id']) {
        $subjects[$subject['Subject']['id']] = $subject['Subject']['name'];
      }
    }
    return $subjects;
  }
}
