<script src="../../js/marks.js" type="text/javascript"></script>
<link rel="stylesheet" href="../../css/marks.css">
<script src="../../js/fancybox/jquery.fancybox-1.3.4.js" type="text/javascript"></script>
<link rel="stylesheet" href="../../js/fancybox/jquery.fancybox-1.3.4.css">
<script>
	jQuery.fn.CheckNumber = function(){
		$(this).keydown(function(e)
		{
			if ( event.keyCode == 46 || event.keyCode == 8 ) {
						// let it happen, don't do anything
				}
				else {
						// Ensure that it is a number and stop the keypress
						if (event.keyCode < 48 || event.keyCode > 57 ) {
								event.preventDefault(); 
						}       
				}
		});
	}
	
	
	$(document).ready(function() {
		$('.mark_active').CheckNumber();
		$("#new_mark_type").fancybox({
				'titlePosition'	: 'inside',
				'overlayColor'	: '#000',
				'overlayOpacity': 0.5
		});
	});
</script>
<?php
echo '<img src="../../img/alert_y50.png" style="vertical-align:middle;"><span class="title"> '.$subject_now['Subject']['name'].'</span> to obecnie przeglądany przedmiot';
?>

<div class="spacer"></div>
</br>
<span class="title"><img src="../../img/students_marks_32.png" style="vertical-align: middle;"> Oceny</span>
<table class="marks" style="">
  <tr>
  <th class="left title_mark bg6" style="padding-left:8px;">l.p</th>
  <th class="center title_mark bg6">Imię</th>
  <th class="center title_mark bg6" style="padding-left:10px;">Nazwisko</th>
  <?php foreach ($descriptions as $description): ?>
  <th class="title_mark  bg4"><span class="title_of_mark " title="<center><?php echo htmlspecialchars($description['Description']['type']).' - '.htmlspecialchars($description['Description']['description']); ?> <br/><small>Kliknij aby usunąć</small></center>"><?php echo substr($description['Description']['type'],0,4); ?></span> </th>
  <?php endforeach; ?>
  <th class="center title_mark bg6"><a id="new_mark_type" href="#new_mark"><img src="/img/plus.gif" class="title_of_mark" title="Dodaj nowy typ oceny" style="cursor:pointer;" style="vertical-align: middle"></a></th>
  <th class="center title_mark bg6" ><img src="/img/average_ico.png" class="title_of_mark" title="Średnia z podanych ocen"></th>
  </tr>
  <?php $i=0;?>
  <?php foreach ($students as $student): ?>
  <?php if($i%2 == 0)  {$style = "_";$name = 'white';} else { $style = ""; $name = 'gray';} ?>
  <!-- UCZEŃ -->
  <tr>
    <td class="right border_b student_record<?php echo $style; ?>" style="padding-right:5px;"><?php ++$i; echo '<b>'.$i.'.</b>'; ?></td>	
    <td class="left border_b student_record<?php echo $style; ?>"><?php echo $student['Student']['first_name']; ?></td>	
    <td class="left border_b student_record<?php echo $style; ?>" style="padding-left:10px;border-right:1px solid #eee;"><?php echo $student['Student']['last_name']; ?></td>
    
    <!-- OCENY -->
		<?php $number_of_marks = 0;
		$mark_all_value = 0; ?>
      <?php foreach ($descriptions as $description): ?>
	  
      <?php $mark = $mark_model->findByDescriptionIdAndStudentId($description['Description']['id'], $student['Student']['id']); ?>
      <td style="border-right:1px solid #eee;" class="mark <?php echo $name; ?> border_b" id="<?php echo $student['Student']['id'] . '_' . $description['Description']['id']; ?>">
        <?php
			echo $mark['Mark']['mark'];
			if(!empty($mark['Mark']['mark']) && $mark['Mark']['mark'] != 'nb' && $mark['Mark']['mark'] != 'zw'){
				$number_of_marks++;
				$mark_all_value = $mark_all_value+$mark['Mark']['mark'];
			}
		?>
      </td>
      <?php ?>
      <?php endforeach; ?>
      
    <!-- OCENY -->
    
  <!-- PUSTKA -->
    <th style="border:none;border-left:1px solid #eee;border-right:1px solid #eee;background:none"></td>
  <!-- ŚREDNIE -->
  <td class="mark_average"><?php 
	if($number_of_marks > 0 && $mark_all_value > 0){
		echo round($mark_all_value/$number_of_marks,2);
	}  ?></td>
  </tr>
  
  <?php endforeach; ?>
  
  <!-- UCZEŃ -->
 <tr>
  <th class="left title_mark bg6" style="padding-left:8px;">l.p</th>
  <th class="center title_mark bg6">Imię</th>
  <th class="center title_mark bg6" style="padding-left:10px;">Nazwisko</th>
  <?php foreach ($descriptions as $description): ?>
  <th class="title_mark  bg4"><span class="title_of_mark " title="<center><?php echo htmlspecialchars($description['Description']['type']).' - '.htmlspecialchars($description['Description']['description']); ?> <br/><small>Kliknij aby usunąć</small></center>"><?php echo substr($description['Description']['type'],0,4); ?></span> </th>
  <?php endforeach; ?>
  <th class="center title_mark bg6"></th>
  <th class="center title_mark bg6" ><img src="../../img/average_ico.png" class="title_of_mark" title="Średnia z podanych ocen"></th>
  </tr>
</table>

</br>
<!-- DODAWANIE NOWEGO TYPU OCENY -->
<div style="display: none;">
	<div id="new_mark" style="width:auto;height:auto;overflow:auto;">
		<img src="../../img/marks_type.png" style="vertical-align:middle;"><span class="title">Dodaj nowy typ oceny</span>
		<div class="spacer-fancy"></div>
		<table style="margin:0 auto;border-radius:5px;">
		  <?php echo $this->Form->create('Description', array('action' => 'create'));?>
		  <tr><td>Typ:</td><td><?php echo $this->Form->input('type', array('type' => 'text', 'label'=>''));?></td></tr>
		  <tr><td>Opis:</td><td><?php echo $this->Form->input('description', array('type' => 'text', 'label'=>''));?></td></tr>
		  <tr><td>Kolor:</td><td><?php echo $this->Form->input('colour', array('type' => 'text', 'label'=>''));?></td></tr>
		  <tr><td colspan="2" class="right"><?php echo $this->Form->input('subject_id', array('value' => $this->params['id'], 'type' => 'hidden') ); echo $this->Form->end('Dodaj');?> </td></tr>
		</table>
	</div>
</div>
<!-- DODAWANIE NOWEGO TYPU OCENY -->

<script type="text/javascript">
  //Występuje błąd, do bazy wprowadzane jest 0, podczas gdy klikamy i nie wpisujemy żadnej oceny.
  // BŁĄD SZEROKOŚCI BAAARDZO IRYTUJĄCY
  $(function() {
    var parsed_id;

    $('.mark').live('click', function() {
      var clone = $(this).clone();
      parsed_id = $(this).attr('id').split('_');
      var old_mark = clone.text();
      clone.text('');
      clone.append('<input id="mark_active" class="mark_active" name="data[Mark][mark]" type="text" value="' + old_mark + '">');
      $(this).replaceWith(clone);
      $('#' + clone.attr('id')).children().focus();
    });

    $('#mark_active').live('blur', function() {
      var mark = $(this).val();
      if(mark == '1') { mark = '1'; 
	  }  else if(mark == '1'){ mark = '1'; 
	  }	 else if(mark == '1+'){ mark = '1&#43;'; 
	  }  else if(mark == '1-'){ mark = '1&#45;'; 
	  }  else if(mark == '2'){ mark = '2'; 
	  }  else if(mark == '2+'){ mark = '2'; 
	  }  else if(mark == '2-'){ mark = '2&#45;'; 
	  }  else if(mark == '3'){ mark = '3'; 
	  }  else if(mark == '3+'){ mark = '3&#43;'; 
	  }  else if(mark == '3-'){ mark = '3&#45;'; 
	  }	 else if(mark == '4'){ mark = '4'; 
	  }  else if(mark == '4+'){ mark = '4&#43;'; 
	  }  else if(mark == '4-'){ mark = '4&#45;'; 
	  }	 else if(mark == '5'){ mark = '5'; 
	  }  else if(mark == '5+'){ mark = '5&#43;'; 
	  }  else if(mark == '5-'){ mark = '5-'; 
	  }  else if(mark == '6'){ mark = '6'; 
	  }  else if(mark == '6+'){ mark = '6&#43;'; 
	  }  else if(mark == '6-'){ mark = '6&#45;'; 
	  }  else if(mark == 'nb'){ mark = 'nb'; 
	  }  else if(mark == 'zw'){ mark = 'zw'; 
	  }  else {
		 mark = ''; 
	  }
     
      var data = 'data[Mark][mark]=' + mark +
      '&data[Mark][student_id]=' + parsed_id[0] +
      '&data[Mark][description_id]=' + parsed_id[1] +
      '&data[Mark][subject_id]=' + <?php echo $this->params['id']; ?> +
      '&data[Mark][class_id]=' + <?php echo $this->Session->read('Auth.User.class_id');?>
      + '&data[Mark][semester_id]=' + <?php echo $this->Session->read('Auth.User.semester_id'); ?>;
      $.ajax({
        type: 'POST',
        url: '/teacher/marks/update',
        data: data,
      });
      $(this).replaceWith(mark);
	   alert(data);
    });
  });
</script>
