<?php
  echo $this->Session->flash('auth');
  echo $this->Form->create('User', array('action' => 'login'));
  echo $this->Form->input('username', array('label' => 'Login'));
  echo $this->Form->input('password', array('label' => 'Hasło'));
  echo $this->Form->end('Zaloguj');
?>
