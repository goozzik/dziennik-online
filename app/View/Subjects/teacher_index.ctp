<span class="title"><img src="../../img/subjects_32.png" style="vertical-align: middle"> Wybierz przedmiot</span>

	<?php if (empty($subjects)): ?>
		<table>
			 <tr><td><?php echo 'Nie masz żadnych przedmiotów. Możesz dodać przedmiot poprzez poniższy formularz.'; ?></td></tr>
		</table>
	<?php endif ?>
	<table>
	
  <?php 
  $i=1;
  foreach ($subjects as $subject): ?>
	  
		<tr>
			<td style="padding-right:5px;" class="border_b"><b><?php echo $i; ?></b></td>
			<td class="border_b"><?php echo $this->Html->link($subject['Subject']['name'], '/teacher/subject/' . $subject['Subject']['id']); ?></td>
			<td class="border_b"><?php echo $this->Html->link('Pokaż oceny', '/teacher/subject/' . $subject['Subject']['id'], array('class'=>'manage')); ?></td>
			<td class="border_b"><?php echo $this->Html->link('Edytuj', '/teacher/subjects/edit/' . $subject['Subject']['id'], array('class'=>'manage')); ?></td>
			<td class="border_b"><?php echo $this->Html->link('Usuń', '/teacher/subjects/delete/' . $subject['Subject']['id'], array('class'=>'manage')); ?></td>
		</tr>
	 
  <?php $i++; 
  endforeach; ?>
 </table>
</br>
<span class="title"><img src="../../img/subjects_add_32.png" style="vertical-align: middle"> Dodaj nowy przedmiot</span>

<table>
	<?php echo $this->Form->create('Subject', array('controller' => 'subjects', 'action' => 'create'));?>
	<tr><td>Nazwa</td><td><?php echo $this->Form->input('name', array('label' => ''));?></td></tr>
	<tr><td colspan="2" class="right"><?php echo $this->Form->end('Dodaj');?></td></tr>
	
	
	
