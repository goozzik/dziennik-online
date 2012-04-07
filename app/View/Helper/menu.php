<?php
class MenuHelper extends AppHelper {

  function teacherMenu() {
    echo '<div class="menu">
						<center>
							<ul class="nav">
            		<li class="first"><a href="/">Strona główna</a></li><li><a href="/teacher/students">Uczniowie</a></li><li><a href="/teacher/subjects">Oceny</a></li><li><a href="/teacher/documents">Dokumenty</a></li><li><a href="/teacher/time_tables">Plan lekcji</a></li><li><a href="/teacher/subject_teachers">Nauczyciele</a></li><li><a href="">Raporty</a></li><li><a href="/teacher/absences">Frekwencja</a></li><li><a href="">Ustawienia</a></li><li><a href="/teacher/school_classes">Ustawienia klas</a></li><li class="last"><a href="/users/logout">Wyloguj</a></li>
        			</ul>
						</center>
					</div>';
  }

  function studentMenu() {
    echo '<ul>
            <li class="first"><a href="#">Uczniowie</a></li><li><a href="">Oceny</a></li><li><a href="">Dokumenty</a></li><li><a href="">Plan lekcji</a></li><li><a href="">Nauczyciele</a></li><li><a href="">Raporty</a></li><li><a href="">Frekwencja</a></li><li><a href="">Ustawienia</a></li></li><li class="last"><a href="/users/logout">Wyloguj</a></li>
          </ul>';
  }

  function adminMenu() {
    echo '<div class="menu">
						<center>
							<ul class="nav">
			          <li class="first"><a href="/">Strona główna</a></li>
			          <li><a href="/">Dodaj nauczyciela</a></li>
			          <li><a href="/">Dodaj dyrektora</a></li>
			          <li><a href="/">Konta</a></li>
			          <li><a href="/">Dokumenty</a></li>
			          <li><a href="/">Ustawienia</a></li>
			          <li class="last"><a href="/users/logout">Wyloguj</a></li>
			        </ul>
						</center>
					</div>';
  }

}
?>