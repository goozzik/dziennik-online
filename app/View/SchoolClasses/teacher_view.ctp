<h1><?php echo $class['SchoolClass']['name'] . ' ' . $class['SchoolClass']['yearbook']; ?></h1>

<h1>Ustaw tą klasę jako aktywną</h1>
<?php
echo $this->Form->create('Teacher', array('teacher' => true, 'controller' => 'teachers', 'action' => 'edit'));
echo $this->Form->input('class_id', array('type' => 'hidden', 'value' => $this->params['id']));
echo $this->Form->end('Ustaw');
?>