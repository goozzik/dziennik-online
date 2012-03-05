<h1>Nauczyciele</h1>

<table>
<tr>
      <th align="left">Przedmiot</th>
      <th style="padding-right:30px;">Imię oraz nazwisko</th>
	  <th>więcej informacji</th>
	  <th>usuń</th>
</tr>
  <?php foreach ($teachers as $teacher): ?>
    <tr>
      <td><a href="/teacher/subject/<?php echo $teacher['Subject']['id']?>"><?php echo $teacher['Subject']['name']?></a></td>
      <td><?php echo $teacher['SubjectTeacher']['first_name'] . ' ' . $teacher['SubjectTeacher']['last_name']; ?></td>
	  <td><a href="/teacher/subject_teachers/view/<?php echo $teacher['SubjectTeacher']['id']?>">usuń</a></td>
	  <td><a href="/teacher/subject_teachers/delete/<?php echo $teacher['SubjectTeacher']['id']?>">usuń</a></td>
    </tr>
  <?php endforeach ?>
</table>

<?php if (!empty($subjects)): ?>
  <h1>Dodaj nowego nauczyciela</h1>
  
	<table>
	<?php echo $this->Form->create('SubjectTeacher', array('controller' => 'subject_teachers', 'action' => 'create'));?>
    <tr><td>Imię</td><td><?php echo $this->Form->input('first_name', array('label' => ''));?></td></tr>
    <tr><td>Nazwisko</td><td><?php echo $this->Form->input('last_name', array('label' => ''));?></td></tr>
    <tr><td>Przemiot którego uczy:</td><td><?php echo $this->Form->select('subject_id', $subjects);?></td></tr>
	<tr><td>Godziny zajęć:</td><td><?php echo $this->Form->textarea('work_hours', array('label' => '', 'style'=>'height:100px;'));?></td></tr>
	<tr><td>Telefon</td><td><?php echo $this->Form->input('telephone', array('label' => ''));?></td></tr>
	<tr><td>e-mail</td><td><?php echo $this->Form->input('mail', array('label' => ''));?></td></tr>
    <tr><td colspan="2"><?php echo $this->Form->end('Dodaj');?></td></tr>   
  </table>
<?php endif ?>
