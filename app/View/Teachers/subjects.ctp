<h1>Przedmioty</h1>
<?php foreach ($subjects as $subject): ?>
  <td><?php echo $this->Html->link($subject['Subject']['name'], '/subjects/' . $subject['Subject']['id']); ?></td>
</tr>
<?php endforeach; ?>