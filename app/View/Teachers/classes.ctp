<h1>Klasy</h1>
<ul>
  <?php foreach ($classes as $class): ?>
    <li><?php echo $class['SchoolClass']['name'] . ' ' . $class['SchoolClass']['yearbook']; ?></li>
  <?php endforeach; ?>
</ul>

<h1>Dodaj nową klasę</h1>
  <?php
    echo $this->Form->create('SchoolClass', array('controller' => 'school_classes', 'action' => 'create'));
    echo $this->Form->input('name');
    echo $this->Form->input('yearbook');
    echo $this->Form->end('Dodaj');
  ?>
</form>
