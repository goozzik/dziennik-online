<?php
class Student extends User {
  public $name = 'Student';
  public $hasOne = 'Teacher';
}
