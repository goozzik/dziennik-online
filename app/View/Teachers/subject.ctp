<h1>Oceny</h1>
<table>
  <tr>
    <th>Imię</th>
    <th>Nazwisko</th>
    <?php foreach ($descriptions as $description): ?>
      <th><?php echo $description['Description']['description']; ?> </th>
    <?php endforeach; ?>
  </tr>

  <?php foreach ($students as $student): ?>
    <tr>
      <td><?php echo $student['Student']['first_name'] ?></td>
      <td><?php echo $student['Student']['last_name'] ?></td>
      <?php foreach ($descriptions as $description): ?>
        <td><?php $mark = $mark_model->findByDescriptionIdAndStudentId($description['Description']['id'], $student['Student']['id']); echo $mark['Mark']['mark']?></td>
      <?php endforeach; ?>
    </tr>
  <?php endforeach; ?>
</table>

<h1>Dodaj Nową ocenę</h1>
  <?php
  echo $this->Form->create('Description', array('action' => 'create'));
  echo $this->Form->input('description', array('type' => 'text', 'label' => 'Opis'));
  echo $this->Form->input('subject_id', array('value' => $this->params['subject_id'], 'type' => 'hidden') ); 
  echo $this->Form->end('Dodaj');
  ?>
</form>
