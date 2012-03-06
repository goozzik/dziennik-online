<link rel="stylesheet" type="text/css" href="/css/absences.css" />
<div class="navigation">
</div>
<table>
  <tr>
    <th colspan='2' rowspan='1'>

    <?php foreach ($month as $week): ?>
      <th colspan='4'><?php echo $week['date']; ?></th>
    <?php endforeach ?>
    <th>%</th>
  </tr>

  <tr>
    <td><strong>Imię</strong></td>
    <td><strong>Nazwisko</strong></td>

    <?php foreach ($month as $week): ?>
      <td><strong>obow</strong></td>
      <td><strong>uspr</strong></td>
      <td><strong>nieuspr</strong></td>
      <td><strong>spóź</strong></td>
    <?php endforeach ?>
  </tr>

  <?php foreach ($students as $student): ?>
    <tr>
      <td><?php echo $student['Student']['first_name']; ?></td>
      <td><?php echo $student['Student']['last_name']; ?></td>
      <?php foreach ($month as $week): ?>
        <?php
          $absence = $Absence->findByDateAndStudentId($week['date'], $student['Student']['id']);
          $absence_html_id = $student['Student']['id'] . '_' . $week['date'] ;
        ?>

        <td class='absence' id='<?php echo $absence_html_id . '_required'?>'><?php echo $absence['Absence']['required']; ?></td>
        <td class='absence' id='<?php echo $absence_html_id . '_justified'?>'><?php echo $absence['Absence']['justified']; ?></td>
        <td  class='absence' id='<?php echo $absence_html_id . '_unexcused'?>'><?php echo $absence['Absence']['unexcused']; ?></td>
        <td  class='absence' id='<?php echo $absence_html_id . '_late'?>'><?php echo $absence['Absence']['late']; ?></td>
      <?php endforeach; ?>
      <?php $absence_report = $Absence->AbsenceReport->findByDateAndStudentId($month[0]['date'], $student['Student']['id']);?>
      <td><?php echo $absence_report['AbsenceReport']['percentage'];?><td>
    </tr>
  <?php endforeach; ?>
</table>

<div class="navigation">
  <a href='/teacher/absences/week/'><< Poprzedni tydzień</a> | 
  <a href='/teacher/absences/week/'>Następny tydzień >></a>
</div>

<script type="text/javascript">
  $(function() {
    var parsed_id;

    $('.absence').live('click', function() {
      var clone = $(this).clone();
      parsed_id = $(this).attr('id').split('_');
      old_absence = clone.text();
      clone.text('');
      clone.append('<input id="absence_active" type="text" value="' + old_absence + '">');
      $(this).replaceWith(clone);
      $('#' + clone.attr('id')).children().focus();
    });

    $('#absence_active').live('blur', function() {
      var value = $(this).val();
      var data = 'data[Absence][student_id]=' + parsed_id[0] +
      '&data[Absence][date]=' + parsed_id[1] +
      '&data[Absence][' + parsed_id[2] + ']=' + value;
      $.ajax({
        type: 'POST',
        url: '/teacher/absences/update',
        data: data,
      });
      $(this).replaceWith(value);
    });

  });
</script>
