	<script src="../../js/marks.js" type="text/javascript"></script>
	<link rel="stylesheet" href="/css/marks.css">

	<?php
	echo '<img src="../../img/alert_y50.png" style="vertical-align:middle;"><span class="title"> '.$subject_now['Subject']['name'].'</span> to obecnie przeglądany przedmiot';
	?>

	<div class="spacer"></div>
	</br>
	<span class="title"><img src="../../img/students_marks_32.png" style="vertical-align: middle"> Oceny</span>
	<table class="marks" style="">
	  <tr>
		<th class="left title_mark bg6" style="padding-left:8px;">l.p</th>
		<th class="center title_mark bg6">Imię</th>
		<th class="center title_mark bg6" style="padding-left:10px;">Nazwisko</th>
		<?php foreach ($descriptions as $description): ?>
		<th class="title_mark  bg4"><span class="title_of_mark " title="<center><?php echo htmlspecialchars($description['Description']['type']).' - '.htmlspecialchars($description['Description']['description']); ?> <br/><small>Kliknij aby usunąć</small></center>"><?php echo substr($description['Description']['type'],0,4); ?></span> </th>
		<?php endforeach; ?>
		<th class="center title_mark bg6"><img src="/img/plus.gif" class="title_of_mark" title="Dodaj nowy typ oceny" style="cursor:pointer;" style="vertical-align: middle" onclick="alert('Tutaj okno dodania typu oceny');"></th>
		<th class="center title_mark bg6" ><img src="/img/average_ico.png" class="title_of_mark" title="Średnia z podanych ocen"></th>
	  </tr>
	  <?php $i=0;?>
	  <?php foreach ($students as $student): ?>
	  <?php if($i%2 == 0)  {$style = "_";$name = 'white';} else { $style = ""; $name = 'gray';} ?>
		<!-- UCZEŃ -->
		<tr>
		  <td class="right border_b student_record<?php echo $style; ?>" style="padding-right:5px;"><?php ++$i; echo '<b>'.$i.'.</b>'; ?></td>	
		  <td class="left border_b student_record<?php echo $style; ?>"><?php echo $student['Student']['first_name']; ?></td>	
		  <td class="left border_b student_record<?php echo $style; ?>" style="padding-left:10px;"><?php echo $student['Student']['last_name']; ?></td>
		  
		  <!-- OCENY -->
			  <?php foreach ($descriptions as $description): ?>
				<?php $mark = $mark_model->findByDescriptionIdAndStudentId($description['Description']['id'], $student['Student']['id']); ?>
				<td class="mark <?php echo $name; ?> border_b" id="<?php echo $student['Student']['id'] . '-' . $description['Description']['id'] . '-' . $mark['Mark']['id']; ?>">
				  <?php echo $mark['Mark']['mark']?>
				</td>
				<?php ?>
			  <?php endforeach; ?>
			  
		  <!-- OCENY -->
		  
		<!-- PUSTKA -->
			<th style="border-left:1px solid #eee;"></td>
		<!-- ŚREDNIE -->
		<td class="mark_average">4.5</td>
		</tr>
		
	  <?php endforeach; ?>
	  
	  <!-- UCZEŃ -->
	 <tr>
		<th class="left title_mark bg6" style="padding-left:8px;">l.p</th>
		<th class="center title_mark bg6">Imię</th>
		<th class="center title_mark bg6" style="padding-left:10px;">Nazwisko</th>
		<?php foreach ($descriptions as $description): ?>
		<th class="title_mark  bg4"><span class="title_of_mark " title="<center><?php echo htmlspecialchars($description['Description']['type']).' - '.htmlspecialchars($description['Description']['description']); ?> <br/><small>Kliknij aby usunąć</small></center>"><?php echo substr($description['Description']['type'],0,4); ?></span> </th>
		<?php endforeach; ?>
		<th class="center title_mark bg6"><img src="../../img/plus.gif" class="title_of_mark" title="Dodaj nowy typ oceny" style="cursor:pointer;" style="vertical-align: middle" onclick="alert('Tutaj okno dodania typu oceny');"></th>
		<th class="center title_mark bg6" ><img src="../../img/average_ico.png" class="title_of_mark" title="Średnia z podanych ocen"></th>
	  </tr>
	</table>

	</br>
	<img src="../../img/marks_type.png" style="vertical-align:middle;"><span class="title">Dodaj nowy typ oceny</span>
	<div class="spacer"></div>
	<table>
		<?php echo $this->Form->create('Description', array('action' => 'create'));?>
		<tr><td>Typ:</td><td><?php echo $this->Form->input('type', array('type' => 'text', 'label'=>''));?></td></tr>
		<tr><td>Opis:</td><td><?php echo $this->Form->input('description', array('type' => 'text', 'label'=>''));?></td></tr>
		<tr><td>Kolor:</td><td><?php echo $this->Form->input('colour', array('type' => 'text', 'label'=>''));?></td></tr>
		<tr><td colspan="2" class="right"><?php echo $this->Form->input('subject_id', array('value' => $this->params['id'], 'type' => 'hidden') ); echo $this->Form->end('Dodaj');?> </td></tr>
	</table>

	<script type="text/javascript">
		//Występuje błąd, do bazy wprowadzane jest 0, podczas gdy klikamy i nie wpisujemy żadnej oceny.
		// BŁĄD SZEROKOŚCI BAAARDZO IRYTUJĄCY
	  $(function() {
		var update = false;
		
		
		
		$('.mark').live('click', function() {
		  var clone = $(this).clone();
		  var old_mark;
		  if(clone.text()) {
			update = true;
			old_mark = clone.text();
			clone.text('');
		  } else { update = false; }
		  if(update) {
			clone.append('<input id="mark_active" class="mark_active" name="data[Mark][mark]" type="text" value="' + old_mark + '">');
		  } else {
			clone.append('<input id="mark_active" class="mark_active" name="data[Mark][mark]" type="text">');
		  }
		  $(this).replaceWith(clone);
			$('#' + clone.attr('id')).children().focus();
		});

		$('#mark_active').live('blur', function() {
		  var mark = $(this).val();
		  if(parseInt(mark)<1) { mark = '1'; }
		  if(parseInt(mark)>6) { mark = '6'; }
		  var parsed_id = $(this).parent().attr('id').split('-');
		  var data = 'data[Mark][mark]=' + mark +
			'&data[Mark][student_id]=' + parsed_id[0] +
			'&data[Mark][description_id]=' + parsed_id[1] +
			'&data[Mark][subject_id]=' + <?php echo $this->params['id']; ?> +
			'&data[Mark][class_id]=' + <?php echo $this->Session->read('Auth.User.class_id');?> +
			'&data[Mark][semester_id]=' + <?php echo $this->Session->read('Auth.User.semester_id'); ?>;
		  if(update) {
			data = data + '&data[Mark][id]=' + parsed_id[2];
			$.ajax({
			  type: 'POST',
			  url: '/teacher/marks/edit',
			  data: data,
			});
		  } else {
			/*$.ajax({
			  type: 'POST',
			  url: '/teacher/marks/create',
			  data: data,
			});*/
		  }
		  $(this).replaceWith(mark);
		});

	  });
	</script>