<?php
	$mysql = @new mysqli('localhost', 'root', '', 'allegro_manager');
	if(mysqli_connect_errno() != 0) {
		echo 'Niestety wyst¹pi³ b³¹d po³¹czenia z baz¹ danych, spróbuj ponownie póŸniej.';
		exit;
	}
?>
