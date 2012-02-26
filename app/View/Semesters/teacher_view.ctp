<span class="title">Ustaw semestr jako aktywny:</span>
<br/>
<span style="font-weight:normal"><?php echo '<strong>' . $semester['Semester']['semester'] . ' semestr</strong>' . ', klasa: <strong>'. $class['SchoolClass']['year'] . $class['SchoolClass']['name'] .'</strong> '.$class['SchoolClass']['profile'].' ' . $class['SchoolClass']['yearbook']; ?></span>
<br/><br/>

<?php
echo $this->Form->create('Teacher', array('teacher' => true, 'controller' => 'teachers', 'action' => 'edit'));
echo $this->Form->input('class_id', array('type' => 'hidden', 'value' => $class['SchoolClass']['id']));
echo $this->Form->input('semester_id', array('type' => 'hidden', 'value' => $semester['Semester']['id']));
echo $this->Form->end('Ustaw');
?>