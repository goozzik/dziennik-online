<div style="margin: 0 auto;width:400px;">

<?php
  echo $this->Session->flash('auth');
  echo $this->Form->create('User', array('action' => 'login'));
  ?>
  <style>
	table.login_panel input[type=password]{
		background:url('/img/pass_.png') no-repeat;
		background-position:2px center;
		background-color:white; 
		padding-left:18px;
	}
	
	table.login_panel input[type=text].login{
		background:url('/img/login_.png') no-repeat;
		background-position:2px center;
		background-color:white; 
		padding-left:18px;
	}
  </style>
  
  <table style="background-color:#ebebeb;border-radius:2px;padding:10px;" class="login_panel">
	<tr><td style="width:100px;">Login</td><td><?php echo $this->Form->input('username', array('label' => '', 'class' => 'login'));?></td></tr>
	<tr><td>Hasło<br/><a href="" style="font-size:8pt;color:#999;font-weight:normal;">Nie pamiętasz hasła?</a></td><td><?php echo $this->Form->input('password', array('label' => '', 'style'=>''));?></td></tr>
	<tr><td colspan="2"><div class="spacer" style="width:100%;"></div></td></tr>
	<tr><td colspan="2" style="text-align:right;"><?php echo $this->Form->end('Zaloguj');?></td></tr>
  </table>
</div>