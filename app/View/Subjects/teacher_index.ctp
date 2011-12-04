<h1>Przedmioty</h1>
<ul>
  <?php foreach ($subjects as $subject): ?>
    <li><?php echo $this->Html->link($subject['Subject']['name'], '/teacher/subject/' . $subject['Subject']['id']); ?></li>
  <?php endforeach; ?>
</ul>