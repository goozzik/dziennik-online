<table>
  <tr>
    <th colspan='2' rowspan='2'>
    <?php foreach ($week as $day): ?>
      <?php if (empty($day['time_table'])) { continue; } ?>
      <th colspan='<?php echo count($day['time_table']['Lesson']); ?>'><?php echo $day['day']; ?></th>
    <?php endforeach ?>
  </tr>

  <tr> 
    <?php foreach ($week as $day): ?>
      <?php if (empty($day['time_table'])) { continue; } ?>
      <?php foreach ($day['time_table']['Lesson'] as $lesson): ?>
        <td><?php echo $lesson['lesson_number'] ?></td>
      <?php endforeach ?>
    <?php endforeach ?>
  </tr> 

  <?php foreach ($students as $student): ?>
    <tr>
      <td><?php echo $student['Student']['first_name']; ?></td>
      <td><?php echo $student['Student']['last_name']; ?></td>
      <?php foreach ($week as $day): ?>
        <?php if (empty($day['time_table'])) { continue; } ?>
        <?php foreach ($day['time_table']['Lesson'] as $lesson): ?>
          <?php
            $absence = $Absence->findByLessonAndDateAndStudentIdAndClassId(
              $lesson['lesson_number'],
              $day['day'],
              $student['Student']['id'], 
              $this->Session->read('Auth.User.class_id'));
            $absence_html_id = $student['Student']['id'] . '_' . $day['day'] . '_' . $lesson['lesson_number'] . '_' . $absence['Absence']['id'];
          ?>
          <td class='absence' id='<?php echo $absence_html_id ?>'>
            <?php echo $Absence->normalizeType($absence['Absence']['type']); ?>
          </td>
        <?php endforeach ?>
      <?php endforeach ?>
    </tr>
  <?php endforeach; ?>
</table>

<script type="text/javascript">
  $(function() {
    var update = false;

    $('.absence').live('click', function() {
      var clone = $(this).clone();
      var old_absence;
      if(clone.text()) {
        update = true;
        old_absence = clone.text();
        clone.text('');
      } else { update = false; }
      if(update) {
        clone.append('<input id="absence_active" name="absence[Absence][type]" type="text" value="' + old_absence + '">');
      } else {
        clone.append('<input id="absence_active" name="absence[Absence][type]" type="text">');
      }
      $(this).replaceWith(clone);
      $('#' + clone.attr('id')).children().focus();
    });

    $('#absence_active').live('blur', function() {
      var absence_type = $(this).val();
      switch (absence_type) {
        case '|':
          db_absence_type = 'absence'; break;
        case 'u':
          db_absence_type = 'escape'; break;
        case 'z':
          db_absence_type = 'exemption'; break;
        case '$':
          db_absence_type = 'justification'; break;
      }
      var parsed_id = $(this).parent().attr('id').split('_');
      var data = 'data[Absence][type]=' + db_absence_type +
        '&data[Absence][student_id]=' + parsed_id[0] +
        '&data[Absence][date]=' + parsed_id[1] +
        '&data[Absence][lesson]=' + parsed_id[2];
      if(update) {
        data = data + '&data[Absence][id]=' + parsed_id[3];
        $.ajax({
          type: 'POST',
          url: '/teacher/absences/edit',
          data: data,
        });
      } else {
        $.ajax({
          type: 'POST',
          url: '/teacher/absences/create',
          data: data,
        });
      }
      $(this).replaceWith(absence_type);
    });

  });
</script>
