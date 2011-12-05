<h1>Uczniowie</h1>
<?php if (empty($students)): ?>
  <ul><li>Nie masz żadnych uczniów. Możesz dodać ucznia poprzez poniższy formularz.</li></ul>
<?php else: ?>
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
<?php endif ?>

<h1>Dodaj nowego ucznia</h1>
  <?php
  echo $this->Form->create('Student', array('action' => 'create'));
  echo $this->Form->input('first_name');
  echo $this->Form->input('last_name');
  echo $this->Form->end('Dodaj');
  ?>
</form>
