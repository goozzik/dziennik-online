<h1>Nauczyciele</h1>

<table>
  <?php foreach ($teachers as $teacher): ?>
    <tr>
      <td><?php echo $teacher['Subject']['name']?></td>
      <td><?php echo $teacher['SubjectTeacher']['first_name'] . ' ' . $teacher['SubjectTeacher']['last_name']; ?></td>
	  <td>usuń</td>
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
    <tr><td colspan="2"><?php echo $this->Form->end('Dodaj');?></td></tr>   
  </table>
<?php endif ?>
