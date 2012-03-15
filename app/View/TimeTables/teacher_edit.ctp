<h1><?php //echo $time_table['TimeTable']['id']; ?></h1>
<center>
<?php
	echo $this->Form->create('TimeTable', array('action' => 'edit'));
	echo '<table style="">';
  
  for($i = 0; $i<10 ;$i++) {
    echo '<tr><td>';
      echo $this->Form->label('subject_id', $i . ' Lekcja');
	echo '</td><td>';
      echo $this->Form->select('Lesson][' . $i . '][subject_id', $lessons);
    echo '</td><tr>';
  }
  echo '<tr><td colspan="2" align="right">';
  echo $this->Form->end('Zapisz');
  echo '</td></tr></table>';
?>
</center>