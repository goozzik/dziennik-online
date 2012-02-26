<?php
class SemestersController extends AppController {
  public $name = 'Semesters';

  function beforeFilter() {
    if ($this->params['teacher']) {
      $this->isTeacherFilter();
      if ($this->action == 'teacher_view') {
        $this->isOwningClassFilter();
      }
    }
  }

  function isOwningClassFilter()
  {
   # $class = $this->Semester->SchoolClass->findById($this->params['id']);
	#$this->Teacher->SchoolClass->findById($this->request->data['Teacher']['class_id']);
   # if($class['SchoolClass']['teacher_id'] != $this->currentUser('id')) {
   #   $this->Session->setFlash('Brak dostępu.', 'flash_error');
   #   $this->redirect($this->referer());
   # }
  }

  function teacher_create() {
  #TWORZYMY NOWY SEMESTR DO!
 	
		if(!empty($this->params['pass'][0]) && !empty($this->params['pass'][1])){
			
			$class = $this->Semester->SchoolClass->findById($this->params['pass'][0]);
			$semester = $this->Semester->findByClassIdAndSemester($this->params['pass'][0],$this->params['pass'][1]);
			#print_r( $semester);
			if(empty($semester['Semester']['semester']) && $class){
			
				$this->set('class', $class['SchoolClass']['id']);
				$this->set('semester', $this->params['pass'][1]);
		  
				if ($this->request->is('post')) {
			  
					#$this->Semester->create();
					
					if ($this->Semester->save($this->request->data)) {
				  
						$this->Session->setFlash('Dodano nowy semestr.', 'flash_success');
						$this->redirect(array('controller' => 'school_classes', 'action' => 'index'));
				  } else {
						$this->Session->setFlash('1Wystąpił błąd podczas dodawania semestru.', 'flash_error');
				  }
				} else {
					#$this->Session->setFlash('Wystąpił błąd podczas dodawania semestru.', 'flash_error');
				}
				
			} else {
		
				$this->Session->setFlash('2Wystąpił błąd podczas dodawania nowego semestru, spróbuj ponownie później.', 'flash_error');
				$this->redirect(array('controller' => 'school_classes', 'action' => 'index'));
			}
		} else {
			$this->Session->setFlash('3Wystąpił błąd podczas dodawania nowego semestru, błędny link, spróbuj ponownie później.', 'flash_error');
			$this->redirect(array('controller' => 'school_classes', 'action' => 'index'));
		}
	}
  function teacher_index() {
	$this->redirect($this->referer());
  }

  function teacher_view() {
  
  $semester = $this->Semester->findById($this->params['pass'][1]);
  $class = $this->Semester->SchoolClass->findById($this->params['pass'][0]);
	if($semester && $class){
		$this->set('class', $class );
		$this->set('semester', $semester);
	} else {
		 $this->Session->setFlash('Wybrana klasa lub semestr nie istnieją.', 'flash_error');
		 $this->redirect(array('controller' => 'school_classes', 'action' => 'index'));
	}
	
  }
  
}