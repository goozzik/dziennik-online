<?php
class MarkSemestersController extends AppController {
  public $name = 'MarkSemesters';

  function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();
      if ($this->action == 'teacher_create' || $this->action == 'teacher_edit') {
        $this->isOwningClassFilter();
      }
    }
  }

  function isOwningClassFilter()
  {
    if($this->request->data['MarksSemester']['class_id'] != $this->currentUser('class_id')) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }
	
	function teacher_index(){
		
	
	}
	
	function teacher_update2() {
     if ($this->request->is('post')) {
      $mark = $this->MarksSemester->findAllBySubjectIdAndStudentId($this->request->data['MarksSemester']['subject_id'],$this->request->data['MarksSemester']['student_id']);
	  print_r($mark);
	  $this->request->data['MarksSemester']['mark'];
	  
	  if ($mark) {
        $this->MarksSemester->id = $mark[0]['MarksSemester']['id'];
      } else {
        $this->MarksSemester->create();
		echo 1;
      }
      if($this->MarksSemester->save($this->request->data)){
		echo 'dodano';
	  } else {
		echo 'wystapil blad';
	  }
	  echo 2;
    }
	
    $this->autoRender = true; 
  }
  
    function teacher_update() {
	print_r($this->request);
    if ($this->request->is('post')) {
      $mark = $this->MarkSemester->findByClassIdAndSemesterIdAndStudentId($this->request->data['MarkSemester']['class_id'], $this->request->data['MarkSemester']['semester_id'], $this->request->data['MarkSemester']['student_id']);
	  #$this->request->data['MarksSemester']['mark'] = rawurlencode($this->request->data['MarksSemester']['mark']);
	  if ($mark) {
		echo 1;
        $this->MarkSemester->id = $mark['MarkSemester']['id'];
      } else {
        $this->MarkSemester->create();
      }
      $this->MarkSemester->save($this->request->data);
    } else {
		echo 'dupa';
	}
    $this->autoRender = true;
  }

}
