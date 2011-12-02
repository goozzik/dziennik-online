<?php
class Description extends AppModel {
  public $name = 'Description';
  public $belongsTo = 'Subject';
  public $hasMany = 'Mark';

}
