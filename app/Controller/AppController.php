<?php
class AppController extends Controller {
  public $helpers = array('Html','Form','Menu','Session');
  public $components = array('Auth','Session');
}
