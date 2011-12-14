<h1>Nauczyciele</h1>

<table>
  <?php foreach ($teachers as $teacher): ?>
    <tr>
      <td><?php echo $teacher['Subject']['name']?></td>
      <td><?php echo $teacher['SubjectTeacher']['first_name'] . ' ' . $teacher['SubjectTeacher']['last_name']; ?></td>
    </tr>
  <?php endforeach ?>
</table>
