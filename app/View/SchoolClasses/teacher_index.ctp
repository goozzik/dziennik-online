<?php if (!empty($classes)): ?>
  <span class="title">Klasy</span>
  <table>
    <?php foreach ($classes as $class): ?>
	    <tr>
	    	<td>
			    <?php echo $class['SchoolClass']['year'] . $class['SchoolClass']['name'] . ' ' . $class['SchoolClass']['yearbook']; ?>
		    </td>
		  </tr>
		
			<!-- WYŚWIETLANIE SEMESTRÓW DLA DANEJ KLASY -->
			<?php foreach ($class['Semester'] as $semester): ?>
				<tr>
					<td style="padding-left:20px;">
						<?php if ($semester_actual == $semester['id'])
							echo 'Semestr ' . $semester['semester'] . ' - aktualnie wybrany';
						else 
							echo 'Semestr ' . $semester['semester'];
							echo '<span style="float:right;">';
							echo $this->Form->create('Teacher', array('teacher' => true, 'controller' => 'teachers', 'action' => 'edit'));
							echo $this->Form->input('class_id', array('type' => 'hidden', 'value' => $class['SchoolClass']['id']));
							echo $this->Form->input('semester_id', array('type' => 'hidden', 'value' => $semester['id']));
							echo $this->Form->end('Ustaw');
							echo '</span>';
						  echo $this->Form->postButton('Delete', array('teacher' => true, 'controller' => 'semesters', 'action' => 'delete', $semester['id']), array('confirm' => 'Jesteś pewien?'));
						?>
					</td>
				</tr>
			<?php endforeach ?>

			<tr>
				<td style="padding-left:20px;">
					<?php 
						echo $this->Form->create('Semester', array('teacher' => true, 'controller' => 'semester', 'action' => 'create'));
						echo $this->Form->input('class_id', array('type' => 'hidden', 'value' => $class['SchoolClass']['id']));
						echo $this->Form->end('Dodaj nowy semestr');
					?>					
				</td>
			</tr>
			<!-- KONIEC WYŚWIETLANIE SEMESTRÓW DLA DANEJ KLASY -->
		
    <?php endforeach ?>
  </table><br/><br/>
  
<?php endif ?>

<span class="title">Dodaj nową klasę</span>
<?php echo $this->Form->create('SchoolClass', array('controller' => 'school_classes', 'action' => 'create'));?>
	<table>
		<tr>
			<td>Klasa rok</td>
			<td><?php echo $this->Form->input('year', array('label' => '', 'type'=>'number', 'value'=>'1'));?></td>
		</tr>
		<tr>
			<td>Nazwa</td>
			<td><?php echo $this->Form->input('name', array('label' => ''));?></td>
		</tr>
		<tr>
			<td>Profil</td>
			<td><?php echo $this->Form->input('profile', array('label' => ''));?></td>
		</tr>
		<tr>
			<td>Rocznik</td>
			<td><?php echo $this->Form->input('yearbook', array('label' => '', 'value' => '2011'));?></td>
		</tr>
		<tr>
			<td colspan="2" align="right"><?php echo $this->Form->end('Dodaj');?></td>
		</tr>
	</table>
<?php echo $this->Form->end(); ?>
	
 
   
    
   
   
    
   
  
