<h1>Klasy</h1>
<ul>
  <?php foreach ($classes as $class): ?>
    <li><?php echo $this->Html->link($class['SchoolClass']['name'] . ' ' . $class['SchoolClass']['yearbook'], '/teacher/school_class/' . $class['SchoolClass']['id']); ?></li>

  <?php endforeach; ?>
</ul>

<h1>Dodaj nową klasę</h1>
  <?php
    echo $this->Form->create('SchoolClass', array('controller' => 'school_classes', 'action' => 'create'));
    echo $this->Form->input('name');
    echo $this->Form->input('yearbook', array('value' => '1990'));
    echo $this->Form->end('Dodaj');
  ?>