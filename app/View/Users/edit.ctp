<span class="title"><img src="../../img/subjects_32.png" style="vertical-align: middle">Ustawienia</span>
<?php
  echo $this->Form->button('Zmień hasło', array('onclick'=>"window.location='/users/change_password';"));
  echo $this->Form->button('Zmień mail', array('onclick'=>"window.location='/users/change_mail';"));
?>
