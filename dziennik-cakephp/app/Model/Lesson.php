<?php
class Lesson extends AppModel {
  public $name = 'Lesson';
  public $belongsTo = array('Subject', 'TimeTable');
  public $actsAs = array('Containable'); 
}
