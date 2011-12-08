<?php
	class TimeTablesController extends AppController {
		 public $name = 'TimeTables';
		 
		public function teacher_index(){
		 
		} 
		 
		public function teacher_add(){
			
				$days_all = $this->TimeTable->findAllByClassId($this->currentUser('class_id'));
				$subjects = $this->TimeTable->SchoolClass->Subject->findAllByClassId($this->currentUser('class_id'));
				
				$days_week = array(
					1 => 'Poniedziałek',
					2 => 'Wtorek',
					3 => 'Środa',
					4 => 'Czwartek',
					5 => 'Piątek',
					6 => 'Sobota',
					7 => 'Niedziela'
				);
				
				foreach($days_all as $day){
					
					unset($days_week[$day['TimeTable']['id']]);
					
				}
				
				foreach($subjects as $value){
				 
					$subject[$value['Subject']['id']] = $value['Subject']['name'];
					
				} 
				
				$this->set('days', $days_week);						 
				$this->set('lessons', $subject);
			}
		
		public function teacher_create(){
			if ($this->request->is('post')) {
			
				 $this->TimeTable->create();
				 
				if ($this->TimeTable->save($this->request->data)) {
					$this->Session->setFlash('Dodano nowy dzień do planu lekcji.', 'flash_success');
					$this->redirect($this->referer());
				}
				
			} 
		}
		
	}
?>