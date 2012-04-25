<?php
class SchoolClassesController extends AppController {

  public $name = 'SchoolClasses';
  public $helpers = array('SchoolClass');

  function beforeFilter() {
    parent::beforeFilter();
    if ($this->action == 'teacher_view' || $this->action == 'teacher_delete') {
      $this->classAuth();
    }
  }

  private function classAuth() {
    if (!$this->SchoolClass->findByIdAndTeacherId($this->params['pass']['0'], $this->currentUser('id'))) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  function teacher_create() {
    if ($this->request->is('post')) {
      $this->SchoolClass->create();
      if ($this->SchoolClass->save($this->request->data)) {
        $this->Session->setFlash('Dodano nową klasę.', 'flash_success');
        $this->redirect(array('controller' => 'school_classes', 'action' => 'index'));
      }
    }
  }

  function teacher_index() {
    $this->set('classes', $this->SchoolClass->findAllByTeacherId($this->currentUser('id')), array(), array('Semesters.id' => 'ASC'));
    $this->set('semester_actual', $this->currentUser('semester_id'));
    $this->set('class_actual', $this->currentUser('class_id'));
  }

  function teacher_delete() {
    if ($this->SchoolClass->delete($this->params['pass']['0'])) {
      $this->Session->setFlash('Usunięto klasę pomyślnie.', 'flash_success');
      $this->redirect('/teacher/school_classes');
    }
  }

}
?>
