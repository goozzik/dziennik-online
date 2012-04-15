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
    ),
    'mail_confirmation' => array(
      'rule' => 'validateMailsMatch',
      'message' => 'Potwierdzenie e-maila nie zgadza się z nowym adresem.',
    ),
    'new_password' => array(
      'rule' => 'notEmpty',
      'message' => 'To pole nie może być puste.'
    )
  );

  function beforeSave() {
    if (!empty($this->data['User']['new_password'])) {
      $this->data['User']['password'] = Security::hash($this->data['User']['new_password'], null, true);
    }
    return true;
  }

  function validateCurrentPassword($current_password) {
    $user = $this->findById($this->id);
    return Security::hash($current_password['current_password'], null, true) == $user['User']['password'];
  }

  function validatePasswordsMatch($password_confirmation) {
    return $password_confirmation['password_confirmation'] == $this->data['User']['new_password'];
  }

  function validateMailsMatch($mail_confirmation) {
    return $mail_confirmation['mail_confirmation'] == $this->data['User']['mail'];
  }

}
?>
