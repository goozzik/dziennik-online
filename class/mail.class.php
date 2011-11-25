<?php
  class Mail {

    public function set_mail_to($var_to)
    {
      $this->mail_to = $var_to;
    }

    public function set_mail_topic($var_topic)
    {
      $this->mail_topic = $var_topic;
    }

    public function set_mail_content($var_content)
    {
      $this->mail_content = $var_content;
    }

    public function send_mail()
    {
      $naglowki = '';

      $naglowki .= "From:" .$this->mail_from.PHP_EOL;
      $naglowki .= "Reply-To:". $this->mail_reply.PHP_EOL;
      $naglowki .= "Content-type: text/html; charset=utf-8".PHP_EOL;
      $naglowki .= "Content-Transfer-Encoding: 8bit";

      if(mail($this->mail_to, $this->mail_topic, $this->mail_content, $naglowki))
      {
        return true;

      } else {

        return false;

      }

    }

  }
?>
