<?php
class MenuHelper extends AppHelper {

  function teacher_menu() {
    echo '<ul>
            <li class="first"><a href="/teacher/students">Uczniowie</a></li>
            <li><a href="/teacher/subjects">Oceny</a></li>
            <li><a href="">Dokumenty</a></li>
            <li><a href="">Plan lekcji</a></li>
            <li><a href="">Nauczyciele</a></li>
            <li><a href="">Raporty</a></li>
            <li><a href="">Frekwencja</a></li>
            <li><a href="">Ustawienia</a></li>
            <li><a href="/teacher/school_classes">Ustawienia klasy</a>
            </li><li class="last"><a href="/users/logout">Wyloguj</a></li>
          </ul>';
  }

  function student_menu() {
    echo '<ul>
            <li class="first"><a href="#">Uczniowie</a></li>
            <li><a href="">Oceny</a></li>
            <li><a href="">Dokumenty</a></li>
            <li><a href="">Plan lekcji</a></li>
            <li><a href="">Nauczyciele</a></li>
            <li><a href="">Raporty</a></li>
            <li><a href="">Frekwencja</a></li>
            <li><a href="">Ustawienia</a></li>
            </li><li class="last"><a href="/users/logout">Wyloguj</a></li>
          </ul>';
  }

}
