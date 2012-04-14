<?php
class User extends AppModel {

  public $name = 'User';

  var $validate = array(
    'current_password' => array(
      'rule' => 'validateCurrentPassword',
      'message' => 'Twoje hasło jest nieprawidłowe.'
    ),
      'password_confirmation' => array(
      'rule' => 'validatePasswordsMatch',
      'message' => 'Potwierdzenie hasła nie zgadza się z nowym hasłem.',
    )
  );

  function beforeSave() {
    $this->data['User']['password'] = Security::hash($this->data['User']['new_password'], null, true);
    return true;
  }

  function validateCurrentPassword($current_password) {
    $user = $this->findById($this->id);
    return Security::hash($current_password['current_password'], null, true) == $user['User']['password'];
  }

  function validatePasswordsMatch($password_confirmation) {
    return $password_confirmation['password_confirmation'] == $this->data['User']['new_password'];
  }

}
?>