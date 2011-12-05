<h1>Przedmioty</h1>
<ul>
  <?php foreach ($subjects as $subject): ?>
    <li><?php echo $this->Html->link($subject['Subject']['name'], '/teacher/subject/' . $subject['Subject']['id']); ?></li>
  <?php endforeach; ?>
</ul>

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
      <td><?php echo $student['Student']['first_name']; ?></td>
      <td><?php echo $student['Student']['last_name']; ?></td>
      <?php foreach ($descriptions as $description): ?>
        <?php $mark = $mark_model->findByDescriptionIdAndStudentId($description['Description']['id'], $student['Student']['id']); ?>
        <td class="mark" id="<?php echo $student['Student']['id'] . '-' . $description['Description']['id'] . '-' . $mark['Mark']['id']; ?>">
          <?php echo $mark['Mark']['mark']?>
        </td>
      <?php endforeach; ?>
    </tr>
  <?php endforeach; ?>
</table>

<h1>Dodaj nową ocenę</h1>
  <?php
    echo $this->Form->create('Description', array('action' => 'create'));
    echo $this->Form->input('description', array('type' => 'text', 'label' => 'Opis'));
    echo $this->Form->input('subject_id', array('value' => $this->params['id'], 'type' => 'hidden') ); 
    echo $this->Form->end('Dodaj');
  ?>
</form>

<script type="text/javascript">
  $(function() {
    var update = false;

    $('.mark').live('click', function() {
      var clone = $(this).clone();
      var old_mark;
      if(clone.text()) {
        update = true;
        old_mark = clone.text();
        clone.text('');
      } else { update = false; }
      if(update) {
        clone.append('<input id="mark_active" name="data[Mark][mark]" type="text" value="' + old_mark + '">');
      } else {
        clone.append('<input id="mark_active" name="data[Mark][mark]" type="text">');
      }
      $(this).replaceWith(clone);
      $('#' + clone.attr('id')).children().focus();
    });

    $('#mark_active').live('blur', function() {
      var mark = $(this).val();
      if(parseInt(mark)<1) { mark = '1'; }
      if(parseInt(mark)>6) { mark = '6'; }
      var parsed_id = $(this).parent().attr('id').split('-');
      var data = 'data[Mark][mark]=' + mark +
        '&data[Mark][student_id]=' + parsed_id[0] +
        '&data[Mark][description_id]=' + parsed_id[1] +
        '&data[Mark][subject_id]=' + <?php echo $this->params['id']; ?> +
        '&data[Mark][class_id]=' + <?php echo $this->Session->read('Auth.User.class_id'); ?>;
      if(update) {
        data = data + '&data[Mark][id]=' + parsed_id[2];
        $.ajax({
          type: 'POST',
          url: '/teacher/marks/edit',
          data: data,
        });
      } else {
        $.ajax({
          type: 'POST',
          url: '/teacher/marks/create',
          data: data,
        });
      }
      $(this).replaceWith(mark);
    });

  });
</script>