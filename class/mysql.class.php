<?php
$db_name = 'dziennik';
  class Mysql {

  var $numb_of_conn; //Pokazuje ³¹czn¹ iloœæ zapytañ na stronie
  var $mysql;

    public function connect(){
      $this -> mysql = @new mysqli('localhost', 'root', '', 'dziennik');
      if(mysqli_connect_errno() != 0) {
        echo 'Niestety wyst¹pi³ b³¹d po³¹czenia z baz¹ danych, spróbuj ponownie póŸniej.';
        exit;
      } else {
        #echo 'Polaczylem z baza danych';
      }
    }

    public function query($query){

      $this -> numb_of_conn++; 
      return $this -> mysql -> query($query);

    }

    public function return_numb_of_conn(){
      echo $this->numb_of_conn;
    }
  }

  /******
    Przyk³ad ³¹czenia z baz¹ danych 
  *******/

  // $mysql = new Mysql();
  // $mysql->connect();
  // $mysql->query("SELECT * FROM `dziennik`.`bells`");
  // $mysql->return_numb_of_conn();



  /******
    Przyk³ad pobierania danych z db
    Wynik obiekt jest rzutowany do tablicy.
  *******/

  // $wynik = $mysql -> query("SELECT * FROM `dziennik`.`bells`") -> fetch_assoc(); 
  // echo $wynik['id'];


?>
