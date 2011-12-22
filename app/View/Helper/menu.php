<?php
class MenuHelper extends AppHelper {

  function teacher_menu() {
    echo '<ul class="nav">
            <li><a href="/teacher/students">Uczniowie</a></li><li><a href="/teacher/subjects">Oceny</a></li><li><a href="">Dokumenty</a></li><li><a href="/teacher/time_tables">Plan lekcji</a></li><li><a href="/teacher/subject_teachers">Nauczyciele</a></li><li><a href="">Raporty</a></li><li><a href="/teacher/absences">Frekwencja</a></li><li><a href="">Ustawienia</a></li><li><a href="/teacher/school_classes">Ustawienia klasy</a></li><li><a href="/users/logout">Wyloguj</a></li>
          </ul>';
  }

  function student_menu() {
    echo '<ul>
            <li><a href="#">Uczniowie</a></li><li><a href="">Oceny</a></li><li><a href="">Dokumenty</a></li><li><a href="">Plan lekcji</a></li><li><a href="">Nauczyciele</a></li><li><a href="">Raporty</a></li><li><a href="">Frekwencja</a></li><li><a href="">Ustawienia</a></li></li><li><a href="/users/logout">Wyloguj</a></li>
          </ul>';
  }

}
