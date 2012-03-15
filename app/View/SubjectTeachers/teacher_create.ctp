<script src="../../js/fancybox/jquery.fancybox-1.3.4.js" type="text/javascript"></script>
<link rel="stylesheet" href="../../js/fancybox/jquery.fancybox-1.3.4.css">
<script>
	$(document).ready(function() {
		$("#new_teacher").fancybox({
				'titlePosition'	: 'inside',
				'overlayColor'	: '#000',
				'overlayOpacity': 0.5
		});
		
		$("#new_teacher").fancybox().trigger('click');
	});
</script>
<span class="title">Nauczyciele</span>
<span class="title" style="float:right;"><a href="#new_teacher_form" id="new_teacher"><img src="/img/student_add_32.png" style="vertical-align: middle"> Dodaj nowego nauczyciela</a></span>

<table>
<tr>
      <th align="left">Przedmiot</th>
      <th align="left" style="padding-right:20px;min-width:150px;">Imię oraz nazwisko</th>
	  <th align="left" style="padding-right:20px;">więcej</th>
	  <th align="left">usuń</th>
</tr>
  <?php foreach ($teachers as $teacher): ?>
    <tr>
      <td><a href="/teacher/subject/<?php echo $teacher['Subject']['id']?>"><?php echo $teacher['Subject']['name']?></a></td>
      <td><?php echo $teacher['SubjectTeacher']['first_name'] . ' ' . $teacher['SubjectTeacher']['last_name']; ?></td>
	  <td><a href="/teacher/subject_teachers/view/<?php echo $teacher['SubjectTeacher']['id']?>">więcej</a></td>
	  <td><a href="/teacher/subject_teachers/delete/<?php echo $teacher['SubjectTeacher']['id']?>">usuń</a></td>
    </tr>
  <?php endforeach ?>
</table>

<?php if (!empty($subjects)): ?>
<div style="display:none;">
<div id="new_teacher_form">
  <h1>Dodaj nowego nauczyciela</h1>
  
	<table>
	<?php echo $this->Form->create('SubjectTeacher', array('controller' => 'subject_teachers', 'action' => 'create'));?>
    <tr><td>Imię</td><td><?php echo $this->Form->input('first_name', array('label' => ''));?></td></tr>
    <tr><td>Nazwisko</td><td><?php echo $this->Form->input('last_name', array('label' => ''));?></td></tr>
    <tr><td>Przemiot którego uczy:</td><td><?php echo $this->Form->select('subject_id', $subjects);?></td></tr>
	<tr><td>Godziny zajęć:</td><td><?php echo $this->Form->textarea('work_hours', array('label' => '', 'style'=>'height:100px;'));?></td></tr>
	<tr><td>Telefon</td><td><?php echo $this->Form->input('telephone', array('label' => ''));?></td></tr>
	<tr><td>e-mail</td><td><?php echo $this->Form->input('mail', array('label' => ''));?></td></tr>
    <tr><td colspan="2" align="right"><?php echo $this->Form->end('Dodaj');?></td></tr>   
  </table>
  </div>
  </div>
<?php endif ?>
