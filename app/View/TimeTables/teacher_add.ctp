<h1>Dodaj nowy dzień do planu lekcji</h1>
  <?php
    echo $this->Form->create('TimeTable', array('action' => 'create'));
    echo $this->Form->label('week_day', 'Dzień');
    echo $this->Form->select('week_day', $days);
    for($i = 0; $i<10 ;$i++) {
      echo $this->Form->label('subject_id', $i . ' Lekcja');
      echo $this->Form->select('Lesson][' . $i . '][subject_id', $lessons);
    }
    echo $this->Form->end('Dodaj nowy dzień');
  ?>
</form>
