<span class="title">Dodaj nowy semestr do klasy</span>
<?php
echo $this->Form->create('Semester', array('teacher' => true, 'controller' => 'semester', 'action' => 'create/'.$class.'/'.$semester));
echo $this->Form->input('post', array('type' => 'hidden', 'value' => '1'));
echo $this->Form->input('class_id', array('type' => 'hidden', 'value' => $class));
echo $this->Form->input('semester', array('type' => 'hidden', 'value' => $semester));

echo $this->Form->end('Potwierdź dodanie');
?>	