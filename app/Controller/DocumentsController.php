<?php
class DocumentsController extends AppController {
  public $name = 'Documents';

	function beforeFilter() {
	
	}

	function teacher_index() {
		$this->set('files',$this->Document->findAllByClassId($this->currentUser('class_id')));
		
	}
	
	function teacher_add(){
		if (!empty($this->data) && is_uploaded_file($this->data['Document']['file']['tmp_name'])) {
            $fileData = fread(fopen($this->data['Document']['file']['tmp_name'], "r"), $this->data['Document']['file']['size']);
			$path = WWW_ROOT.'documents\files\\';
			
            $this->request->data['Document']['class_id'] = $this->currentUser('class_id');
            $this->request->data['Document']['semester_id'] = $this->currentUser('semester_id');
            $this->request->data['Document']['name'] = $this->data['Document']['file']['name'];
			
            $this->request->data['Document']['type'] = $this->data['Document']['file']['type'];
            $this->request->data['Document']['size'] = $this->data['Document']['file']['size'];
            #$this->request->data['Document']['date'] = date("Y-m-d H:m:s");
            $this->request->data['Document']['date'] = '';
			
			$item = 0; //numer pliku aby zachować indywidualnośc nazw
			while(file_exists($path.$item.'_'.$this->request->data['Document']['name'])){
				$item++;
			}
			
			$this->request->data['Document']['name'] = $item.'_'.$this->request->data['Document']['name'];
			$this->request->data['Document']['path'] = $path.$this->request->data['Document']['name'];
			
				if(is_uploaded_file($this->data['Document']['file']['tmp_name']))
				{
					if(move_uploaded_file($this->data['Document']['file']['tmp_name'], $path.$this->request->data['Document']['name']."")){
						$this->Document->save($this->data);
						$this->Session->setFlash('Plik został wgrany pomyślnie.', 'flash_success');
						$this->redirect($this->referer());
					} else {
						$this->Session->setFlash('Wystąpił błąd podczas wgrywania pliku, spróbuj ponownie później.', 'flash_error');
						$this->redirect($this->referer());
					}
				} else {
				
					$this->Session->setFlash('Wybierz plik który chcesz wgrać.', 'flash_error');
					$this->redirect($this->referer());
					
				}
        }
	}
	
	function teacher_delete() {
		if ($this->Document->delete($this->params['pass'][0])) {
		  $this->redirect($this->referer());
		} else {
		  $this->redirect($this->referer());
		}
	}
}
