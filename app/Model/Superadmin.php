<?php
App::import('Model','User');
class Superadmin extends User {
  public $name = 'Superadmin';
  public $useTable = 'users';
  public $primaryKey = 'id';
}
