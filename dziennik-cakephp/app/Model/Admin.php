<?php
App::import('Model','User');
class Admin extends User {
  public $name = 'Admin';
  public $hasOne = 'School';
  public $useTable = 'users';
  public $primaryKey = 'id';
}
