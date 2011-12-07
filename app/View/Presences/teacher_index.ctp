<ul>
  <table>

    <tr>
      <th colspan="2" rowspan='2'>
      <?php foreach ($week as $day): ?>
        <th><?php echo $day['day']; ?></th>
      <?php endforeach ?>
    </tr>
    <tr> 
      <?php foreach ($week as $day): ?>
        <td><?php echo $day['time_table']['Lesson']['count']; ?></th>
      <?php endforeach ?>
    </tr> 

    <?php foreach ($students as $student): ?>
      <tr>
        <td><?php echo $student['Student']['first_name']; ?></td>
        <td><?php echo $student['Student']['last_name']; ?></td>
      </tr>
    <?php endforeach; ?>
  </table>
</ul>
