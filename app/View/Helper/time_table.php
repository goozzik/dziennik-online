<?php
class TimeTableHelper extends AppHelper {

  function intToDay($int) {
    switch ($int) {
      case 1: return 'Poniedziałek';
      case 2: return 'Wtorek';
      case 3: return 'Środa';
      case 4: return 'Czwartek';
      case 5: return 'Piątek';
      case 6: return 'Sobota';
      case 0: return 'Niedziela';
    }
  }

  function subjectIdToName($id) {
    App::import('model', 'Subject');
    $Subject = new Subject();
    $subject = $Subject->findById($id);
    return $subject['Subject']['name'];
  }

}
