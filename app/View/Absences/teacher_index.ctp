<ul>
  <table>

    <tr>
      <th colspan='2' rowspan='2'>
      <?php foreach ($week as $day): ?>
        <th colspan='<?php echo count($day['time_table']['Lesson']); ?>'><?php echo $day['day']; ?></th>
      <?php endforeach ?>
    </tr>
    <tr> 
      <?php foreach ($week as $day): ?>
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
          <?php foreach ($day['time_table']['Lesson'] as $lesson): ?>
            <td>
              <?php 
                $absence = $Absence->findByLessonAndDateAndStudentId($lesson['lesson_number'], $day['day'], $student['Student']['id']);
                  echo $absence['Absence']['type'];
              ?>
            </td>
          <?php endforeach ?>
        <?php endforeach ?>
      </tr>
    <?php endforeach; ?>
  </table>
</ul>
