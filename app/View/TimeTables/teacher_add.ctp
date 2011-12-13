<form action='/teacher/time_tables/index'><input type='submit' value='Powrót'/></form>
<h1>Dodaj nowy dzień do planu lekcji</h1>
<?php
  echo $this->Form->create('TimeTable', array('action' => 'create'));
  echo '<div>';
    echo $this->Form->label('week_day', 'Dzień');
    echo $this->Form->select('week_day', $days, array('empty' => false));
  echo '</div>';
  for($i = 0; $i<10 ;$i++) {
    echo '<div>';
      echo $this->Form->label('subject_id', $i . ' Lekcja');
      echo $this->Form->select('Lesson][' . $i . '][subject_id', $lessons, array('empty' => false));
    echo '</div>';
  }
  echo $this->Form->end('Dodaj nowy dzień');
?>
