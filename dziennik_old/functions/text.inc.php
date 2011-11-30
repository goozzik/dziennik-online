<?php
  function sText($s){
    return addslashes(htmlspecialchars($s));
  }

  function uText($s){
    return stripslashses($s);
  }

?>
