<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
  <head>
    <link rel="stylesheet" href="/css/default.css">
    <link rel="stylesheet" href="/css/menu.css">
    <link rel="stylesheet" href="/js/jquery.confirm/jquery.confirm.css">
    <script src="/js/jquery.js" type="text/javascript"></script>
    <script src="/js/jquery.qtip.min.js" type="text/javascript"></script>
    <script src="/js/jquery.confirm/jquery.confirm.js" type="text/javascript"></script>
    <script src="/js/prompt.js" type="text/javascript"></script>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body>
  <div class="site">
    <div class="logo">
      <a href="/"><img src="/img/logo.png"></a>
    </div>
    <div class='menu'>
      <?php
        if($this->Session->read('Auth.User.teacher')) {
          $this->Menu->teacherMenu();
        } elseif ($this->Session->read('Auth.User.student')) {
          $this->Menu->studentMenu();
        } elseif ($this->Session->read('Auth.User.admin')) {
          $this->Menu->adminMenu();
        } elseif ($this->Session->read('Auth.User.director')) {
          $this->Menu->directorMenu();
        }
      ?>
    </div>
    <div class='container'>
      <?php
        echo $this->Session->flash();
        echo $content_for_layout;
      ?>
    </div>
    <div class="footer">
      <?php
        if($this->Session->read('Auth.User.teacher')) {
          $this->Footer->footer();
        } elseif($this->Session->read('Auth.User.student')) {
          $this->Footer->footer();
        }
      ?>
    </div>
  </div>
  <body>
</html>
