<?php
class SubjectsController extends AppController {
  public $name = 'Subjects';

  function beforeFilter() {
    if ($this->params['teacher']) {
      parent::isTeacherFilter();
      if ($this->action == 'teacher_view') {
        $this->isOwningSubjectFilter();
      }
      if ($this->action == 'teacher_index') {
        $this->isClassSet();
      }
    }
  }

  function isOwningSubjectFilter()
  {
    if (!$this->Subject->findByIdAndTeacherId($this->params['id'], $this->currentUser('id'))) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  function teacher_index() {
    $this->set('subjects', $this->Subject->findAllByClassId($this->currentUser('class_id')));
  }

  function teacher_view() {
    $this->set('subjects', $this->Subject->findAllByClassId($this->currentUser('class_id')));
    $this->set('descriptions', $this->Subject->Description->findAllBySubjectId($this->params['id']));
    $this->set('students', $this->Subject->Teacher->Student->findAllByClassIdAndStudent($this->currentUser('class_id'),'1',null,'Student.last_name ASC'));
	#$this->set('students', $this->Student->findAllByClassIdAndStudent($this->currentUser('class_id'),'1',null,'Student.last_name ASC'));
    $this->set('mark_model', $this->Subject->Description->Mark);
	#$test = new $this->MarksSemesters();;
	$this->set('semester_id',$this->currentUser('semester_id'));
    $this->set('marks_semesters', $this->Subject->MarkSemesters);
    $this->set('subject_now', $this->Subject->findByClassIdAndId($this->currentUser('class_id'),$this->params['id']));
  }

  function teacher_create()
  {
    if ($this->request->is('post')) {
      $this->Subject->create();
      if ($this->Subject->save($this->request->data)) {
        $this->Session->setFlash('Dodano nowy przedmiot.', 'flash_success');
        $this->redirect($this->referer());
      }
    }
  }
  
   function teacher_delete()
   {
    if($this->Subject->delete($this->params['pass'][0])){
		$this->redirect($this->referer());
		
	} else {
		$this->redirect($this->referer());
	}

   }
}
