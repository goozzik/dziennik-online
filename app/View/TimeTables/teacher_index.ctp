<div class='row'>
  <?php foreach ($time_tables as $time_table): ?>
    <div class='span3'>
      <table>
        <tr><th colspan='2'><?php echo $this->TimeTable->intToDay($time_table['TimeTable']['week_day']); ?></th></tr>
        <?php foreach ($time_table['Lesson'] as $lesson): ?>
          <tr>
            <td><?php echo $lesson['lesson_number']?></td>
            <td><?php echo $this->TimeTable->subjectIdToName($lesson['subject_id']); ?></td>
          </tr>
        <?php endforeach; ?>
      </table>
      <form action='/teacher/time_tables/edit/<?php echo $time_table['TimeTable']['id']; ?>'><input type='submit' value='Edytuj'/></form>
    </div>
  <?php endforeach; ?>
</div>

<form action='/teacher/time_tables/add'><input type='submit' value='Dodaj nowy dzień'/></form>
