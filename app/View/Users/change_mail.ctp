<?php echo $this->Form->create('User', array('controller' => 'users', 'action' => 'edit'));?>
<table style="margin:0 auto;border-radius:5px;">
  <tr>
    <td colspan="2" style="border-bottom:1px solid #ddd;background-color:#eee">Zmień adres e-mail:</td>
  </tr>
  <tr>
    <td>Nowy adres:</td><td><?php echo $this->Form->input('mail', array('type' => 'text', 'label'=>''));?></td>
  </tr>
  <tr>
    <td>Powtórz:</td><td><?php echo $this->Form->input('mail_confirmation', array('type' => 'text', 'label'=>''));?></td>
  </tr>
  <tr>
    <td>Hasło:</td>
    <td><?php echo $this->Form->input('current_password', array('type' => 'password', 'label'=>''));?></td>
  </tr>
  <tr>
    <td colspan="2" class="right"><?php echo $this->Form->end('Zmień e-mail'); ?></td>
  </tr>
</table>
