<?php
class SubjectTeachersController extends AppController {
  public $name = 'SubjectTeachers';

  function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();	
      if ($this->action == 'teacher_index' || $this->action == 'teacher_create') {
        $this->isClassSet();
      }
    }
  }

  function teacher_index() {
    $this->set('teachers', $this->SubjectTeacher->findAllByClassId($this->currentUser('class_id')));
    $this->set('subjects', $this->SubjectTeacher->Subject->findAllByClassIdAndNoTeacher($this->currentUser('class_id')));
	#print_r($this->SubjectTeacher->Subject->findAllByClassIdAndNoTeacher($this->currentUser('class_id')));
  }

  function teacher_create() {
  $this->set('teachers', $this->SubjectTeacher->findAllByClassId($this->currentUser('class_id')));
  $this->set('subjects', $this->SubjectTeacher->Subject->findAllByClassIdAndNoTeacher($this->currentUser('class_id')));
    if ($this->request->is('post')) {
      $this->SubjectTeacher->create();
      if ($this->SubjectTeacher->save($this->request->data)) {
        $this->Session->setFlash('Dodano nowego nauczyciela.', 'flash_success');
        $this->redirect('/teacher/subject_teachers');
      }
    }
  }
  
  function teacher_delete()
   {
   $this->set('teachers', $this->SubjectTeacher->findAllByClassId($this->currentUser('class_id')));
   $this->set('subjects', $this->SubjectTeacher->Subject->findAllByClassIdAndNoTeacher($this->currentUser('class_id')));
  
   
    if($this->SubjectTeacher->delete($this->params['pass'][0])){
		#$this->redirect('http://www.example.com');
		header('Location:/teacher/subject_teachers');
		
	} else {
		#$this->redirect('http://www.example.com');
		header('Location:/teacher/subject_teachers');
	} 

   }

}