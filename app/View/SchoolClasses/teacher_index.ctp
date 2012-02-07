<?php if (!empty($classes)): ?>
  <span class="title">Klasy</span>
  <table>
    <?php foreach ($classes as $class): ?>
      <?php echo '<tr><td>> '.$this->Html->link($class['SchoolClass']['name'] . ' ' . $class['SchoolClass']['yearbook'], '/teacher/school_class/' . $class['SchoolClass']['id']) .'</td></tr>'; ?>

    <?php endforeach; ?>
  </table><br/><br/>
<?php endif ?>

<span class="title">Dodaj nową klasę</span>
<?php echo $this->Form->create('SchoolClass', array('controller' => 'school_classes', 'action' => 'create'));?>
	<table>
	<tr><td>Klasa rok</td><td><?php echo $this->Form->input('number', array('label' => '', 'type'=>'number', 'value'=>'1'));?></td></tr>
	<tr><td>Nazwa</td><td><?php echo $this->Form->input('name', array('label' => ''));?></td></tr>
	<tr><td>Profil</td><td> <?php echo $this->Form->input('profile', array('label' => ''));?></td></tr>
	<tr><td>Rocznik</td><td><?php echo $this->Form->input('yearbook', array('label' => '', 'value' => '1990'));?></td></tr>
	<tr><td colspan="2" align="right"><?php echo $this->Form->end('Dodaj');?></td></tr>
	</table>
	
 
   
    
   
   
    
   
  
