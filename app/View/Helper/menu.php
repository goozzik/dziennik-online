<?php
class MenuHelper extends AppHelper {

  function teacher_menu() {
    echo '
	<div class="logo">
		<a href="/"><img src="/img/logo.png"></a>
	</div>
	<div class="menu">
		<ul class="nav">
            <li class="first"><a href="/teacher/students">Uczniowie</a></li><li><a href="/teacher/subjects">Oceny</a></li><li><a href="/teacher/documents">Dokumenty</a></li><li><a href="/teacher/time_tables">Plan lekcji</a></li><li><a href="/teacher/subject_teachers">Nauczyciele</a></li><li><a href="">Raporty</a></li><li><a href="/teacher/absences">Frekwencja</a></li><li><a href="">Ustawienia</a></li><li><a href="/teacher/school_classes">Ustawienia klas</a></li><li class="last"><a href="/users/logout">Wyloguj</a></li>
        </ul>
	<div class="menu">
		  ';
  }

  function student_menu() {
    echo '<ul>
            <li class="first"><a href="#">Uczniowie</a></li><li><a href="">Oceny</a></li><li><a href="">Dokumenty</a></li><li><a href="">Plan lekcji</a></li><li><a href="">Nauczyciele</a></li><li><a href="">Raporty</a></li><li><a href="">Frekwencja</a></li><li><a href="">Ustawienia</a></li></li><li class="last"><a href="/users/logout">Wyloguj</a></li>
          </ul>
		  ';
  }
  
    function footer() {
    echo '
	<span class="informations">
			Udane logowanie : 22-02-2012, 17:54<br/>
			Nieudane logowanie : 22-02-2012, 17:54
		</span>
		<span class="about"></span>
		  ';
  }

}
