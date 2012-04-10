<span class="title"><img src="../../img/subjects_32.png" style="vertical-align: middle"> Ustawienia</span>
	
		<table style="margin:0 auto;border-radius:5px;">
		<tr><td colspan="2" style="border-bottom:1px solid #ddd;background-color:#eee">Zmień hasło:</td></tr>
		  <?php echo $this->Form->create('Settings', array('action' => 'password_change'));?>
		  <tr><td>Stare hasło:</td><td><?php echo $this->Form->input('password_old', array('type' => 'password', 'label'=>''));?></td></tr>
		  <tr><td>Nowe hasło:</td><td><?php echo $this->Form->input('password_1', array('type' => 'password', 'label'=>''));?></td></tr>
		  <tr><td>Powtórz:</td><td><?php echo $this->Form->input('password_2', array('type' => 'password', 'label'=>''));?></td></tr>
		  <tr><td colspan="2" class="right"><?php echo $this->Form->input('subject_id', array('value' => $this->params['id'], 'type' => 'hidden') ); echo $this->Form->end('Zmień hasło');?> </td></tr>
		</table>
		
		<table style="margin:0 auto;border-radius:5px;">
		<tr><td colspan="2" style="border-bottom:1px solid #ddd;background-color:#eee">Zmień adres e-mail:</td></tr>
		  <?php echo $this->Form->create('Settings', array('action' => 'email_change'));?>
		  <tr><td>Nowy email:</td><td><?php echo $this->Form->input('email_1', array('type' => 'text', 'label'=>''));?></td></tr>
		  <tr><td>Powtórz:</td><td><?php echo $this->Form->input('email_2', array('type' => 'text', 'label'=>''));?></td></tr>
		  <tr><td>Podaj hasło:</td><td><?php echo $this->Form->input('email_2', array('type' => 'password', 'label'=>''));?></td></tr>
		  <tr><td colspan="2" class="right"><?php echo $this->Form->input('subject_id', array('value' => $this->params['id'], 'type' => 'hidden') ); echo $this->Form->end('Zmień hasło');?> </td></tr>
		</table>