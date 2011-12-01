<h1>Uczniowie</h1>
<table>
    <tr>
        <th>Imię</th>
        <th>Nazwisko</th>
    </tr>

    <?php foreach ($students as $student): ?>
    <tr>
        <td><?php echo $student['User']['first_name']; ?></td>
        <td><?php echo $student['User']['last_name']; ?></td>
    </tr>
    <?php endforeach; ?>

</table>
