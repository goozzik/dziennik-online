<!-- INFORMACJE O OCENIE JQUERY -->
<script class="example" type="text/javascript">
$(document).ready(function() 
{
   // Match all link elements with href attributes within the content div
   $('.title_of_mark').qtip(
   {
		position: {
         corner: {
            target: 'topRight',
            tooltip: 'bottomLeft'
         }
      },
      style: {
         name: 'cream',
         padding: '7px 13px',
         width: {
            max: 210,
            min: 0
         },
         tip: true
      },
	  content: $(this).attr('title')
		
   });
});
</script>

<!-- INFORMACJE O OCENIE JQUERY -->

<?php
echo '<img src="../../img/alert_y50.png" style="vertical-align:middle;"><span class="title"> '.$subject_now['Subject']['name'].'</span> to obecnie przeglądany przedmiot';
?>

<div class="spacer"></div>
</br>
<span class="title"><img src="../../img/students_marks_32.png" style="vertical-align: middle"> Oceny</span>
<table class="marks">
  <tr>
    <th class="left">l.p</th>
    <th class="left">Imię</th>
    <th class="left" style="padding-left:20px;">Nazwisko</th>
    <?php foreach ($descriptions as $description): ?>
      <th><span class="title_of_mark" title="<?php echo htmlspecialchars($description['Description']['description']); ?>"><?php echo substr($description['Description']['description'],0,4); ?></span> </th>
    <?php endforeach; ?>
  </tr>
  <?php $i=0;?>
  <?php foreach ($students as $student): ?>
  
    <tr>
      <td class="right border_b" style="padding-right:10px;"><?php ++$i; echo '<b>'.$i.'</b>'; ?></td>	
      <td class="left border_b"><?php echo $student['Student']['first_name']; ?></td>	
      <td class="left border_b" style="padding-left:20px;"><?php echo $student['Student']['last_name']; ?></td>
      <?php foreach ($descriptions as $description): ?>
        <?php $mark = $mark_model->findByDescriptionIdAndStudentId($description['Description']['id'], $student['Student']['id']); ?>
        <td class="mark border_b" style="border-left:1px dashed #eee;border-right:1px dashed #eee;text-align:center;width:25px;" id="<?php echo $student['Student']['id'] . '-' . $description['Description']['id'] . '-' . $mark['Mark']['id']; ?>">
          <?php echo $mark['Mark']['mark']?>
        </td>
		<?php ?>
      <?php endforeach; ?>
    </tr>
  <?php endforeach; ?>
</table>
</br>
<img src="../../img/marks_type.png" style="vertical-align:middle;"><span class="title">Dodaj nowy typ oceny</span>
<div class="spacer"></div>
<table>
	<?php echo $this->Form->create('Description', array('action' => 'create'));?>
	<tr><td>Opis</td><td><?php echo $this->Form->input('description', array('type' => 'text', 'label'=>''));?></td></tr>
	<tr><td colspan="2" class="right"><?php echo $this->Form->input('subject_id', array('value' => $this->params['id'], 'type' => 'hidden') ); echo $this->Form->end('Dodaj');?> </td></tr>
</table>

<script type="text/javascript">
	//Występuje błąd, do bazy wprowadzane jest 0, podczas gdy klikamy i nie wpisujemy żadnej oceny.
	// BŁĄD SZEROKOŚCI BAAARDZO IRYTUJĄCY
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
        /*$.ajax({
          type: 'POST',
          url: '/teacher/marks/create',
          data: data,
        });*/
      }
      $(this).replaceWith(mark);
    });

  });
</script>