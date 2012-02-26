<span class="title"><?php echo $class['SchoolClass']['name'] . ' ' . $class['SchoolClass']['yearbook']; ?></span>

<span class="title">Ustaw tą klasę jako aktywną</span>
<?php
echo $this->Form->create('Teacher', array('teacher' => true, 'controller' => 'teachers', 'action' => 'edit'));
echo $this->Form->input('class_id', array('type' => 'hidden', 'value' => $this->params['id']));
echo $this->Form->end('Ustaw');
?>