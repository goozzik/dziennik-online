<?php
class AppController extends Controller {
  public $helpers = array('Html','Form','Menu','Session');
  public $components = array('Auth','Session');

  public $province = array(
			0=>'dolnośląskie',
			1=>'kujawsko-pomorskie',
			2=>'lubelskie',
			3=>'lubuskie',
			4=>'łódzkie',
			5=>'małopolskie',
			6=>'mazowieckie',
			7=>'opolskie',
			8=>'podkarpackie',
			9=>'podlaskie',
			10=>'pomorskie',
			11=>'śląskie',
			12=>'świętokrzyskie',
			13=>'warmińsko-mazurskie',
			14=>'wielkopolskie',
			15=>'zachodniopomorskie'
		); 

  
  
  function currentUser($param) {
    return $this->Session->read('Auth.User.' . $param);
  }

  function isTeacherFilter() {
    if (!$this->currentUser('teacher')) {
  	  $this->Session->setFlash('Brak dostępu.', 'flash_error');
  	  $this->redirect($this->referer());
  	}
  }

  function isClassSet()
  {
    if (!$this->currentUser('class_id')) {
      $this->Session->setFlash('Najpierw ustaw swoją klasę. Możesz to zrobić <a href="/teacher/classes">tutaj</a>', 'flash_error');
      $this->redirect($this->referer());
    }
  }
  
  public function returnProvinceName($province_id){
	return $this->province[$province_id];
  }
  
  
}
