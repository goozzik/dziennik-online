<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
  <head>
    <link rel="stylesheet" href="http://twitter.github.com/bootstrap/1.4.0/bootstrap.min.css">
    <link rel="stylesheet" href="/css/default.css">
    <script src="/js/jquery.js" type="text/javascript"></script>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body>
    <div class='topbar'>
      <div class='topbar-inner'>
        <div class='container'>
          <?php
            if($this->Session->read('Auth.User.teacher')) {
              $this->Menu->teacher_menu();
            } elseif($this->Session->read('Auth.User.student')) {
              $this->Menu->student_menu();
            }
          ?>
        </div>
      </div>
    </div>
    <div class='container'>

      <?php
        echo $this->Session->flash();
        echo $content_for_layout;
      ?>
    </div>
  <body>
</html>
