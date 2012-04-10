<?php
class SemestersController extends AppController {

  public $name = 'Semesters';

  function beforeFilter() {
    parent::beforeFilter();
    if ($this->action == 'teacher_delete') {
      $this->semesterAuth();
    }
  }

  private function semesterAuth() {
    if (!$this->Semester->findByIdAndTeacherId($this->params['pass'][0], $this->currentUser('id'))) {
      $this->Session->setFlash('Brak uprawnień.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  function teacher_create() {
    if ($this->request->is('post')) {
      $this->Semester->create();
      if ($this->Semester->save($this->request->data)) {
        $this->Session->setFlash('Dodano nowy semestr.', 'flash_success');
        $this->redirect($this->referer());
      } else {
        $this->redirect($this->referer());
      }
    }
	}

  function teacher_delete() {
    if ($this->Semester->delete($this->params['pass'][0])) {
      $this->Session->setFlash('Usunięto semestr pomyślnie.', 'flash_success');
      $this->redirect('/teacher/school_classes');
    }
  }
  
}
?>