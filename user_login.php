<?php
include_once('template/layout.class.php');
	
	if(!empty($_POST['user_login'])){

		$user = new User();
		$user -> login = $_POST['user_login'];
		$user -> password = $_POST['user_password'];
		
		
		if(empty($_SESSION['user']['login'])){
		
			if($_SESSION['locked_to'] <= time()){ #jezeli ma zablokowana mozliwosc logowania po 5 probach na 15 min
				
				if($user -> login()){
				
					$_SESSION['locked_to'] = 0; #po poprawnym zalogowaniu resetujemy blokade logowania
					header('Location:index.php');
					
				} else {
					header('Location:user_login.php?error=1'); #bledne haslo
					 
				}
				 
			} else {
		
				if($_SESSION['failed_login'] < 5){ #liczymy ilosc prob blednego logowania
					
					$_SESSION['failed_login']++;
					
				} else {
				
					$_SESSION['locked_to'] = time()+900; #ustawiamy blokade na 15 min
					
				}
				
			}
		} else {
			
			header('Location:index.php');
			
		}
		
	} else {
	
		#formularz logowania
    layout::form_login();
	}
	
	
