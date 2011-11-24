<?php
	class User {
		
		var $login;
		var $first_name; 
		var $last_name;
		var $password; 
		var $email;
		var $account_type; 
		var $class_id; 
		
		public function create(){
			
		}
		
		public function login(){
		global $db_name; //nazwa bazy danych deklarowana w class/mysql.class.php
		global $mysql;   //obiekt po³¹czenia z mysql zadeklarowany w mysql.class.php
		
			$this -> login = sText($this -> login);
			$this -> password = md5($this -> password);
			
			if(!empty($this -> login) && !empty($this -> password)){
			
				#zapytanie do bazy jezeli podany jest login i has³o
				$query = $mysql -> query("SELECT * FROM `$db_name`.`users` WHERE `login` = '$this->login' AND `password` = '$this->password' LIMIT 1");
				
				if(mysqli_num_rows($query)){ #jezeli istenieje taki user w bazie z takim haslem
				
					$result = $query -> fetch_assoc();
					
					# Nadajemy sesje aby potem nie trzeba by³o wykonywaæ niepotrzebnych zapytañ do bazy
					$_SESSION['user']['id'] = $result['id'];
					$_SESSION['user']['login'] = $result['login'];
					$_SESSION['user']['fist_name'] = $result['fist_name'];
					$_SESSION['user']['last_name'] = $result['last_name'];
					$_SESSION['user']['account_type'] = $result['account_type'];
					$_SESSION['user']['password'] = $result['password'];
					$_SESSION['user']['mail'] = $result['mail'];
					$_SESSION['user']['class_id'] = $result['class_id'];
					
					#print_r($_SESSION);
					return 1;
					
				} else {
					
					return 0;
					
				}
				
			}
			
		}
		
		public function change_password(){
		
			
		
		}
		
		public function lost_password(){
		
		}
		
		public function delete(){
		
		}
		
	}
	
?>