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
	});
</script>

<span class="title"><img src="../img/students_32.png" style="vertical-align: middle"> Uczniowie</span>
<?php if (empty($students)): ?>
  <ul><li>Nie masz żadnych uczniów. Możesz dodać ucznia poprzez poniższy formularz.</li></ul>
<?php else: ?>
  <table>
    <tr>
      <th class="left">l.p</th>
      <th class="left">Imię</th>
      <th class="left">Nazwisko</th>
      <th class="left">Login</th>
      <th class="left">Zarządzaj</th>
    </tr>
	<?php $i=1;?>
    <?php foreach ($students as $student): ?>
      <tr>
        <td class="right border_b" style="padding-right:10px;"><?php echo '<b>'.$i.'</b>'; ?></td>
        <td class="border_b" style="padding-right:15px;"><?php echo $student['Student']['first_name']; ?></td>
        <td class="border_b" style="padding-right:15px;"><?php echo $student['Student']['last_name']; ?></td>
        <td class="border_b" style="padding-right:15px;"><?php echo $student['Student']['username']; ?></td>
        <td class="border_b" style="padding-right:15px;">
			<a href="students/view/<?php echo $student['Student']['id'];?>" class="manage" style="margin:0">Więcej</a>
			<a href="students/edit/<?php echo $student['Student']['id'];?>" class="manage">Edytuj</a>
			<a href="/teacher/students/delete/<?php echo $student['Student']['id']; ?>" style="color:#660000" class="manage">Usuń!</a>
		</td>
      </tr>
	  <?php $i++;?>
    <?php endforeach; ?>
  </table>
<?php endif ?>
<br/>
<span class="title"><img src="../img/student_add_32.png" style="vertical-align: middle"> Dodaj nowego ucznia</span>
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
