<?php
class Description extends AppModel {
	
  public $name = 'Description';
  public $belongsTo = array('Semester', 'Subject');
  public $hasMany = 'Mark';

}
