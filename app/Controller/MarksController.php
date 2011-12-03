<?php
class MarksController extends AppController {
  public $name = 'Marks';

  function beforeFilter() {
    if(!($this->request->data['Mark']['class_id'] == $this->Session->read('Auth.User.class_id') && $this->Session->read('Auth.User.teacher'))) {
      $this->Session->setFlash('Brak dostępu.', 'flash_error');
      $this->redirect($this->referer());
    }
  }

  function create() {
    if ($this->request->is('post')) {
      $this->Mark->create();
      if ($this->Mark->save($this->request->data)) {
        # Hash it due its now maintained by ajax requests
        #$this->Session->setFlash('Dodano ocenę.', 'flash_success');
      }
    }
    $this->autoRender = false;
  }

  function edit($id = null) {
    $this->Mark->id = $id;
    if ($this->request->is('post')) {
      if ($this->Mark->save($this->request->data)) {
        # Hash it due its now maintained by ajax requests
        #$this->Session->setFlash('Ocena została zmieniona.', 'flash_success');
        $this->autoRender = false;
      }
    }
  }

}
