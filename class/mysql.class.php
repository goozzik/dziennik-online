<?php
	class Mysql {
	var $numb_of_conn;
	var $mysql;
	
		public function connect(){
			$this -> mysql = @new mysqli('localhost', 'root', '', 'allegro_manager');
			if(mysqli_connect_errno() != 0) {
				echo 'Niestety wyst¹pi³ b³¹d po³¹czenia z baz¹ danych, spróbuj ponownie póŸniej.';
				exit;
			} else {
				#echo 'Polaczylem z baza danych';
			}
		}
		
		public function query($query){
			$this -> mysql -> query($query);
			$this -> numb_of_conn++;
		}
		
		public function return_numb_of_conn(){
			echo $this->numb_of_conn;
		}
	}
	
	// $mysql = new Mysql();
	// $mysql->connect();
	// $mysql->query("SELECT * FROM `dziennik`.`bells`");
	// $mysql->return_numb_of_conn();
	
?>
