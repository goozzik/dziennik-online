<?php
class SubjectTeachersController extends AppController {
  public $name = 'SubjectTeachers';

  function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();	
    }
  }

  function teacher_index() {
    $this->set('teachers', $this->SubjectTeacher->findAllByClassId($this->currentUser('class_id')));
    $this->set('subjects', $this->SubjectTeacher->Subject->findAllByClassIdAndNoTeacher($this->currentUser('class_id')));
  }

  function teacher_create() {
    if ($this->request->is('post')) {
      $this->SubjectTeacher->create();
      if ($this->SubjectTeacher->save($this->request->data)) {
        $this->Session->setFlash('Dodano nowego nauczyciela.', 'flash_success');
        $this->redirect('/teacher/subject_teachers');
      }
    }
  }

}
