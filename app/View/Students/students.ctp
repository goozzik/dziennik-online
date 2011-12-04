<h1>Uczniowie</h1>
<table>
    <tr>
        <th>Imię</th>
        <th>Nazwisko</th>
        <th>Login</th>
    </tr>

    <?php foreach ($students as $student): ?>
    <tr>
        <td><?php echo $student['Student']['first_name']; ?></td>
        <td><?php echo $student['Student']['last_name']; ?></td>
        <td><?php echo $student['Student']['username']; ?></td>
    </tr>
    <?php endforeach; ?>

</table>

<h1>Dodaj nowego ucznia</h1>
  <?php
  echo $this->Session->flash('auth');
  echo $this->Form->create('Student', array('action' => 'create'));
  echo $this->Form->input('first_name');
  echo $this->Form->input('last_name');
  echo $this->Form->end('Dodaj');
  ?>
</form>
