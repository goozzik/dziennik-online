<?php if (empty($student)): ?>
  <ul><li>Wystąpił błąd, gdyż wybrany uczeń nie istnieje.</li></ul>
<?php else: ?>
  <table>
	  <tr><td>Imię</td><td><?php echo $student[0]['Student']['first_name']; ?></td></tr>
	  <tr><td>Nazwisko</td><td><?php echo $student[0]['Student']['last_name'];?></td></tr>
	  <tr><td>Pesel</td><td><?php echo $student[0]['Student']['pesel'];?></td></tr>
	  <tr><td>Numer ewidencyjny ucznia</td><td><?php echo $student[0]['Student']['niu'];?></td></tr>
	  <tr><td>Ulica:</td><td><?php echo $student[0]['Student']['street'];?></td></tr>
	  <tr><td>Miejscowość:</td><td><?php echo $student[0]['Student']['city'];?></td></tr>
	  <tr><td>Kod pocztowy:</td><td><?php echo $student[0]['Student']['zip_code'];?></td></tr>
	  <tr><td>Województwo:</td><td><?php echo $province;?></td></tr>
	  <tr><td>Telefon kontaktowy:</td><td><?php echo $student[0]['Student']['telephone'];?></td></tr>
	  <tr><td>Zajęcia indywidualne:</td><td><?php if($student[0]['Student']['individual'] == 1){echo 'Tak';}else{ echo 'Nie';};?></td></tr>
	  <tr><td>Zamieszkuje w internacie:</td><td><?php if($student[0]['Student']['boarding_school'] == 1){echo 'Tak';}else{ echo 'Nie';};?></td></tr>
  </table>

<?php endif?>