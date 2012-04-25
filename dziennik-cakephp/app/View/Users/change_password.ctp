<?php echo $this->Form->create('User', array('controller' => 'users', 'action' => 'edit'));?>
<table style="margin:0 auto;border-radius:5px;">
  <tr>
    <td colspan="2" style="border-bottom:1px solid #ddd;background-color:#eee">Zmień hasło:</td>
  </tr>
  <tr>
    <td>Bieżące:</td>
    <td><?php echo $this->Form->input('current_password', array('type' => 'password', 'label'=>''));?></td>
  </tr>
  <tr>
    <td>Nowe:</td>
    <td><?php echo $this->Form->input('new_password', array('type' => 'password', 'label'=>''));?></td>
  </tr>
  <tr>
    <td>Powtórz:</td>
    <td><?php echo $this->Form->input('password_confirmation', array('type' => 'password', 'label'=>''));?></td>
  </tr>
  <tr>
    <td colspan="2" class="right"><?php echo $this->Form->end('Zmień hasło');?></td>
  </tr>
</table>
