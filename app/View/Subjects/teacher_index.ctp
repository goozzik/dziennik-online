<h1>Przedmioty</h1>
<ul>
	<?php if (empty($subjects)): ?>
		 <li><?php echo 'Nie masz żadnych przedmiotów. Możesz dodać przedmiot poprzez poniższy formularz.'; ?></li> 
	<?php endif ?>
  <?php foreach ($subjects as $subject): ?>
    <li><?php echo $this->Html->link($subject['Subject']['name'], '/teacher/subject/' . $subject['Subject']['id']); ?></li>
  <?php endforeach; ?>
</ul>

<h1>Dodaj nowy przedmiot</h1>
<?php
	echo $this->Form->create('Subject', array('controller' => 'subjects', 'action' => 'create'));
	echo $this->Form->input('name', array('label' => 'Nazwa'));
	echo $this->Form->end('Dodaj');
?>