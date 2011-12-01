<?php
class Teacher extends User {
  public $name = 'Teacher';
  public $hasMany = 'Student';
}
