<link rel="stylesheet" type="text/css" href="/css/time_table.css" />
<div class='time_tables'>

	<?php $i = 0; ?>
	<?php foreach ($time_tables as $time_table): ?>
	
    
	<div class='time_table_day'>
	<div class="buttons" >
			<a href="/teacher/time_tables/edit/<?php echo $time_table['TimeTable']['id']; ?>"><button class="edit">Edytuj</button></a> 
			<?php echo '<button class="edit" onclick="windowYesNo(\'/teacher/time_tables/delete/' . $time_table['TimeTable']['id'] . '\')" >Usuń</button>'; ?>
		</div>
      <div class="day_" style="vertical-align: bottom;">
		<table class="day" >
			<tr><th colspan='2'><?php echo $this->TimeTable->intToDay($time_table['TimeTable']['week_day']); ?></th></tr>
			
			<?php foreach ($time_table['Lesson'] as $lesson): ?>
		
			  <tr>
				<td class="lesson_number"><?php echo $lesson['lesson_number']?></td>
				<td class="lesson_name"><?php echo $this->TimeTable->subjectIdToName($lesson['subject_id']); ?></td>
			  </tr>
		
			<?php endforeach; ?>
		</table>
	  
		
	</div>	
	</div>
  <?php endforeach; ?>
</div>

<form action='/teacher/time_tables/add' style="clear:both;"><input type='submit' value='Dodaj nowy dzień'/></form>
