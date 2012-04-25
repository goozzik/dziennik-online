<link rel="stylesheet" href="/css/students.css">
<script src="../../js/fancybox/jquery.fancybox-1.3.4.js" type="text/javascript"></script>
<link rel="stylesheet" href="../../js/fancybox/jquery.fancybox-1.3.4.css">
<script type="text/javascript">
		
	jQuery.fn.CheckNumber = function(){
		$(this).keydown(function(e)
		{
			if ( event.keyCode == 46 || event.keyCode == 8 ) {
						// let it happen, don't do anything
				}
				else {
						// Ensure that it is a number and stop the keypress
						if (event.keyCode < 48 || event.keyCode > 57 ) {
								event.preventDefault(); 
						}       
				}
		});
	}
	
	
	
	
	$(document).ready(function() {
		$("#StudentTelephone").CheckNumber(); //http://www.qmike.pl/2010/12/wygodna-walidacja-formularzy-za-pomoca-jquery-i-wtyczki-jquery-validation/
		$("#StudentPesel").CheckNumber(); //http://javascript-ajax.pl/2009/12/02/weryfikacja-numeru-pesel-javascript/
		
		$("#new_student").fancybox({
				'titlePosition'	: 'inside',
				'overlayColor'	: '#000',
				'overlayOpacity': 0.5
		});
	});
</script>

<span class="title"><img src="../img/students_32.png" style="vertical-align: middle"> Uczniowie</span>
<span class="title" style="float:right;"><a href="#new_student_form" id="new_student"><img src="../img/student_add_32.png" style="vertical-align: middle"> Dodaj nowego ucznia</a></span>
<?php if (empty($students)): ?>
  <ul><li>Nie masz żadnych uczniów. Możesz dodać ucznia poprzez poniższy formularz.</li></ul>
<?php else: ?>
  <table class="students">
    <tr>
      <th class="center students_top bg6">l.p</th>
      <th class="center students_top bg6 fisrt_name">Imię</th>
      <th class="center students_top bg6 last_name">Nazwisko</th>
      <th class="center students_top bg6">Login</th>
      <th class="center students_top bg6">NIU</th>
      <th class="center students_top bg6 student_manage">Zarządzaj</th>
    </tr>
	<?php $i=1;?>
    <?php foreach ($students as $student): ?>
      <tr>
        <td class="right border_b" style="padding-right:10px;"><?php echo '<b>'.$i.'</b>'; ?></td>
        <td class="border_b fisrt_name" style="padding-right:15px;"><?php echo $student['Student']['first_name']; ?></td>
        <td class="border_b last_name" style="padding-right:15px;"><?php echo $student['Student']['last_name']; ?></td>
        <td class="border_b" style="padding-right:15px;"><?php echo $student['Student']['username']; ?></td>
        <td class="border_b" style="padding-right:15px;"><?php echo $student['Student']['niu']; ?></td>
        <td class="border_b student_manage" style="padding-right:10px;">
			<a href="students/view/<?php echo $student['Student']['id'];?>" class="manage" style="margin:0">Więcej</a>
			<a href="students/edit/<?php echo $student['Student']['id'];?>" class="manage">Edytuj</a>
			<?php echo '<span onclick="windowYesNo(\'/teacher/students/delete/' . $student['Student']['id'] . '\')" class="link link_delete" style="">Usuń</span>'; ?>
			
		</td>
      </tr>
	  <?php $i++;?>
    <?php endforeach; ?>
	<tr>
      <th class="center students_top bg6">l.p</th>
      <th class="center students_top bg6">Imię</th>
      <th class="center students_top bg6">Nazwisko</th>
      <th class="center students_top bg6">Login</th>
      <th class="center students_top bg6">NIU</th>
      <th class="center students_top bg6">Zarządzaj</th>
    </tr>
  </table>
  
<?php endif ?>
<br/>
<div style="display:none;">
<div id="new_student_form">
	<span class="title" align="left"><img src="../img/student_add_32.png" style="vertical-align: middle;"> Dodaj nowego ucznia</span>
	<table>
	  <?php echo $this->Form->create('Student', array('action' => 'create'));?>
	  <tr><td>Imię</td><td><?php echo $this->Form->input('first_name', array('label' => ''));?></td></tr>
	  <tr><td>Nazwisko</td><td><?php echo $this->Form->input('last_name',array('label' => ''));?></td></tr>
	  <tr><td>Pesel</td><td><?php echo $this->Form->input('pesel',array('label' => '', 'type'=>'text'));?></td></tr>
	  <tr><td>Numer ewidencyjny ucznia</td><td><?php echo $this->Form->input('niu',array('label' => ''));?></td></tr>
	  <tr><td>Ulica:</td><td><?php echo $this->Form->input('street',array('label' => ''));?></td></tr>
	  <tr><td>Miejscowość:</td><td><?php echo $this->Form->input('city',array('label' => ''));?></td></tr>
	  <tr><td>Kod pocztowy:</td><td><?php echo $this->Form->input('zip_code',array('label' => ''));?></td></tr>
	  <tr><td>Województwo:</td><td><?php echo $this->Form->select('province',$province);?></td></tr>
	  <tr><td>Telefon kontaktowy:</td><td><?php echo $this->Form->input('telephone',array('label' => ''));?></td></tr>
	  <tr><td>Zajęcia indywidualne:</td><td align="center"><?php echo $this->Form->radio('individual',array('0' => 'Nie','1' => 'Tak'),array('value'=>'0','legend'=>false));?></td></tr>
	  <tr><td>Zamieszkuje w internacie:</td><td align="center"><?php echo $this->Form->radio('boarding_school',array('0' => 'Nie','1' => 'Tak'),array('value'=>'0','legend'=>false));?></td></tr>
	  <tr><td colspan="2" align="right"><?php echo $this->Form->end('Dodaj');?></td></tr>
	</table>
	</form>
</div>
</div>
