<?php
	$mysql = @new mysqli('localhost', 'root', '', 'allegro_manager');
	if(mysqli_connect_errno() != 0) {
		echo 'Niestety wyst�pi� b��d po��czenia z baz� danych, spr�buj ponownie p�niej.';
		exit;
	}
?>
