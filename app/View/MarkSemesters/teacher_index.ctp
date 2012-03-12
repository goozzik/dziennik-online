<center><table width="700px">
	  <?php echo $this->Form->create('MarksSemesters', array('action' => 'update'));?>
	  <tr><td><?php echo $this->Form->input('mark', array('label' => ''));?></td></tr>
	  <tr><td><?php echo $this->Form->input('student_id', array('label' => '','type'=>'text','value'=>'1'));?></td></tr>
	  <tr><td><?php echo $this->Form->input('subject_id', array('label' => '','type'=>'text'));?></td></tr>
	  <tr><td><?php echo $this->Form->input('class_id', array('label' => '','value'=>$this->Session->read('Auth.User.class_id'),'type'=>'text'));?></td></tr>
	  <tr><td><?php echo $this->Form->input('semester_id', array('label' => '','value'=>$this->Session->read('Auth.User.semester_id'),'type'=>'text'));?></td></tr>
	   <tr><td colspan="2" align="right"><?php echo $this->Form->end('Dodaj');?></td></tr>
	</table>
	</form>
	