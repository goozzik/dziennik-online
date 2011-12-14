<h1>Nauczyciele</h1>

<table>
  <?php foreach ($teachers as $teacher): ?>
    <tr>
      <td><?php echo $teacher['Subject']['name']?></td>
      <td><?php echo $teacher['SubjectTeacher']['first_name'] . ' ' . $teacher['SubjectTeacher']['last_name']; ?></td>
    </tr>
  <?php endforeach ?>
</table>

<?php if (!empty($subjects)): ?>
  <h1>Dodaj nowego nauczyciela</h1>
  <?php
    echo $this->Form->create('SubjectTeacher', array('controller' => 'subject_teachers', 'action' => 'create'));
    echo $this->Form->input('first_name', array('label' => 'Imię'));
    echo $this->Form->input('last_name', array('label' => 'Nazwisko'));
    echo $this->Form->select('subject_id', $subjects);
    echo $this->Form->end('Dodaj');
  ?>
<?php endif ?>
