<link rel="stylesheet" type="text/css" href="/css/absences.css" />
<div class="navigation">
</div>
<table style="font-size:8pt;">
  <tr>
    <th colspan='2' rowspan='1'>

    <?php foreach ($month as $week): ?>
      <th colspan='4'><?php echo $week['date']; ?></th>
    <?php endforeach ?>
    <th>%</th>
    <th>uspr</th>
    <th>n.us</th>
  </tr>

  <tr>
    <td style="border-bottom:2px solid #ddd;"><strong>Imię</strong></td>
    <td style="border-bottom:2px solid #ddd;border-right:2px solid #ddd;"><strong>Nazwisko</strong></td>

    <?php foreach ($month as $week): ?>
      <td style="border-bottom:2px solid #ddd;"><strong>obow</strong></td>
      <td style="border-bottom:2px solid #ddd;"><strong>uspr</strong></td>
      <td style="border-bottom:2px solid #ddd;"><strong>n.us</strong></td>
      <td style="border-bottom:2px solid #ddd;border-right:2px solid #ddd;"><strong>spóź</strong></td>
    <?php endforeach ?>
	<td style="border-bottom:2px solid #ddd;"></td>
	<td style="border-bottom:2px solid #ddd;"></td>
	<td style="border-bottom:2px solid #ddd;"></td>
  </tr>

  <?php foreach ($students as $student): ?>
    <tr>
      <td><?php echo $student['Student']['first_name']; ?></td>
      <td style="border-right:2px solid #ddd;"><?php echo $student['Student']['last_name']; ?></td>
	  <?php $justified_all = 0; $unexcused_all= 0;?>
      <?php foreach ($month as $week): ?>
        <?php
          $absence = $Absence->findByDateAndStudentId($week['date'], $student['Student']['id']);
          $absence_html_id = $student['Student']['id'] . '_' . $week['date'] ;
        ?>
		<?php 
			if($absence['Absence']['justified'] + $absence['Absence']['unexcused'] > $absence['Absence']['required']){
				if($absence['Absence']['justified'] > $absence['Absence']['required']){
					$absence['Absence']['justified'] = '?';
				}
				if($absence['Absence']['unexcused'] > $absence['Absence']['required']){
					$absence['Absence']['unexcused'] = '?';
				}
			}
		?>
        <td class='absence' id='<?php echo $absence_html_id . '_required'?>' style="border-right:1px dashed #ddd;text-align:center;"><?php echo $absence['Absence']['required']; ?></td>
        <td class='absence' id='<?php echo $absence_html_id . '_justified'?>' style="border-right:1px dashed #ddd;text-align:center;"><?php echo $absence['Absence']['justified']; ?></td>
        <td class='absence' id='<?php echo $absence_html_id . '_unexcused'?>' style="border-right:1px dashed #ddd;text-align:center;"><?php echo $absence['Absence']['unexcused']; ?></td>
        <td class='absence' id='<?php echo $absence_html_id . '_late'?>' style="border-right:2px solid #ddd;text-align:center;"><?php echo $absence['Absence']['late']; ?></td>
		<?php 
			$justified_all = $justified_all + $absence['Absence']['justified'];
			$unexcused_all = $unexcused_all + $absence['Absence']['unexcused'];
		?>
      <?php endforeach; ?>
		<?php 
			$absence_report = $Absence->AbsenceReport->findByDateAndStudentId($month[0]['date'], $student['Student']['id']);
			if($justified_all == 0){
				$justified_all = '--';
			}
			
			if($unexcused_all == 0){
				$unexcused_all = '--';
			}
		?>
      <td align="center"><?php if($absence_report['AbsenceReport']['percentage'] == 0){ echo '--';} else { echo round($absence_report['AbsenceReport']['percentage'],2);}?></td>
      <td align="center"><b><?php echo $justified_all;?></b></td>
      <td align="center"><b><?php echo $unexcused_all;?></b></td>
    </tr>
	<?php
	$justified_all = 0;
	$unexcused_all = 0;
	?>
  <?php endforeach; ?>
</table>

<div class="navigation">
<a href='/teacher/absences/month/<?php echo $previous_month; ?>'><< Poprzedni miesiąc</a> |
  <a href='/teacher/absences/month/<?php echo $next_month; ?>'>Następny miesiąc >></a>
</div>

<script type="text/javascript">
  $(function() {
    var parsed_id;

    $('.absence').live('click', function() {
      var clone = $(this).clone();
      parsed_id = $(this).attr('id').split('_');
      old_absence = clone.text();
      clone.text('');
      clone.append('<input id="absence_active" class="absence_active" type="text" value="' + old_absence + '">');
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
