<?php
class DescriptionsController extends AppController {
  public $name = 'Descriptions';

  function beforeFilter() {
    #
  }

  function create() {
    if ($this->request->is('post')) {
      $this->Description->create();
      if ($this->Description->save($this->request->data)) {
        $this->Session->setFlash('Dodano nową ocenę.', 'flash_success');
        $this->redirect($this->referer());
      }
    }
  }

}
