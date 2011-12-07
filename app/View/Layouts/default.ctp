<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
  <head>
    <?php echo $this->Html->css(array('default','menu')); ?>
    <script src="/js/jquery.js" type="text/javascript"></script>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body>
    <div id='menu'>
      <?php
      if($this->Session->read('Auth.User.teacher')) {
        $this->Menu->teacher_menu();
      } elseif($this->Session->read('Auth.User.student')) {
        $this->Menu->student_menu();
      }
      ?>
    </div>
    <div id='content'>
      <?php
        echo $this->Session->flash();
        echo $content_for_layout;
      ?>
    </div>
    <div id='footer'>
    </div>
  <body>
</html>
