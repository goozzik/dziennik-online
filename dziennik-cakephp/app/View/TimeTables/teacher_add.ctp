<form action='/teacher/time_tables/index'><input type='submit' value='Powrót'/></form>
<h1>Dodaj nowy dzień do planu lekcji</h1>
<?php
	echo $this->Form->create('TimeTable', array('action' => 'create'));
	echo '<table style="">';
	echo '<tr><td>';
		echo $this->Form->label('week_day', 'Dzień');
	echo '</td><td>';
		echo $this->Form->select('week_day', $days, array('empty' => false));
	echo '</td><tr>';
  
  for($i = 0; $i<10 ;$i++) {
    echo '<tr><td>';
      echo $this->Form->label('subject_id', $i . ' Lekcja');
	echo '</td><td>';
      echo $this->Form->select('Lesson][' . $i . '][subject_id', $lessons);
    echo '</td><tr>';
  }
  echo '<tr><td colspan="2">';
  echo $this->Form->end('Dodaj nowy dzień');
  echo '</td></tr></table>';
?>
