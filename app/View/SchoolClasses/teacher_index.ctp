<?php if (!empty($classes)): ?>
  <span class="title">Klasy</span>
  <table>
  
    <?php foreach ($classes as $class): ?>

      <?php echo '<tr><td>> '.$class['SchoolClass']['year'].''.$class['SchoolClass']['name'] . ' ' . $class['SchoolClass']['yearbook'].'</td></tr>'; ?>
		
		<!-- WYŚWIETLANIE SEMESTRÓW DLA DANEJ KLASY -->
		
		<?php if (!empty($class['Semester'])):?>
			<?php $new_semester = 1; ?>
		
			
			<?php foreach ($class['Semester'] as $semester):?>
			
				<?php ++$new_semester; ?>
				
				<?php if($semester_actual == $semester['id']):?>
				
				<tr><td style="padding-left:20px;"><?php echo $new_semester; ?>+ <?php echo $semester['semester'] .' - aktualnie wybrany'; ?></td></tr>
				
				<?php else: ?>
					<tr><td style="padding-left:20px;"><?php echo $new_semester; ?>+ <?php echo $this->Html->link($semester['semester'],'/teacher/semesters/view/' . $class['SchoolClass']['id'].'/'.$semester['id']);?> -opcje</td></tr>
				<?php endif ?>
			
			<?php endforeach;?>
				<tr><td style="padding-left:20px;"><?php echo $new_semester; ?>+ <?php echo $this->Html->link('Dodaj nowy semestr','/teacher/semesters/create/' . $class['SchoolClass']['id'].'/'.$new_semester);?></td></tr>
		
		<?php else: ?>
			<?php $new_semester = 1; ?>
			<tr><td style="padding-left:20px;">+ <?php echo $this->Html->link('Dodaj nowy semestr','/teacher/semesters/create/' . $class['SchoolClass']['id'].'/'.$new_semester);?></td></tr>
		<?php endif ?>
		<!-- KONIEC WYŚWIETLANIE SEMESTRÓW DLA DANEJ KLASY -->
		
    <?php endforeach; ?>
  </table><br/><br/>
  
<?php endif ?>

<span class="title">Dodaj nową klasę</span>
<?php echo $this->Form->create('SchoolClass', array('controller' => 'school_classes', 'action' => 'create'));?>
	<table>
	<tr><td>Klasa rok</td><td><?php echo $this->Form->input('year', array('label' => '', 'type'=>'number', 'value'=>'1'));?></td></tr>
	<tr><td>Nazwa</td><td><?php echo $this->Form->input('name', array('label' => ''));?></td></tr>
	<tr><td>Profil</td><td> <?php echo $this->Form->input('profile', array('label' => ''));?></td></tr>
	<tr><td>Rocznik</td><td><?php echo $this->Form->input('yearbook', array('label' => '', 'value' => '2011'));?></td></tr>
	<tr><td colspan="2" align="right"><?php echo $this->Form->end('Dodaj');?></td></tr>
	</table>
	
 
   
    
   
   
    
   
  
