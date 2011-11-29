<?php
  include_once('template/layout.class.php');

  layout::head();
  layout::content();

    if(empty($_SESSION['user']['login'])) {
      layout::sign_in_link();
    } else {
	  layout::head_logged();
      layout::sign_out_link();
    }

  layout::div_end();
?>
