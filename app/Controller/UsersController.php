<?php
class UsersController extends AppController {

  public $name = 'Users';

  function login() {
    if ($this->request->is('post')) {
      if ($this->Auth->login()) {
        $this->Session->setFlash('Zalogowano pomyślnie.');
        if ($this->currentUser('teacher') && !$this->currentUser('class_id')) {
          $this->redirect('/teacher/school_classes');
        }
        $this->redirect('/');
      } else {
        $this->Session->setFlash('Twóje hasło/login jest niepoprawne.');
      }
    }
  }

  function logout() {
    $this->redirect($this->Auth->logout());
  }

  function edit() {
    if (!empty($this->data)) {
      $this->User->id = $this->currentUser('id');
      if ($this->User->save($this->data)) {
        $this->Session->setFlash('Hasło zostało zmienione.');
        $this->redirect('/users/settings');
      } else {
        $this->set('errors', $this->User->invalidFields());
        $this->Session->setFlash('Nie udało się zmienić hasła.');
      }
    } else {
      $this->data = $this->User->findById($this->Auth->user('id'));
    }
  }

}
?>
