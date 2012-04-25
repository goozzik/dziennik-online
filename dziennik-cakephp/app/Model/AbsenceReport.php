<?php
class AbsenceReport extends AppModel {
  public $name = 'AbsenceReport';
  public $belongsTo = array('Student',
                            'SchoolClass' => array('foreignKey' => 'class_id'));
  public $hasMany = 'Absence';
  public $useTable = 'absence_reports';

  function calculateFrequencies($students, $month) {
    foreach ($students as $student) {
      $required = 0;
      $justified = 0;
      $unexcused = 0;
      foreach ($month as $week) {
        $absence = $this->Absence->findByDateAndStudentId($week['date'], $student['Student']['id']);
        $required += (float)$absence['Absence']['required'];
        $justified += (float)$absence['Absence']['justified'];
        $unexcused += (float)$absence['Absence']['unexcused'];
      }
      if ($required == 0) { continue; }
      $percentage = ($required-($justified + $unexcused)) / $required * 100;
      $absence_report = $this->findByStudentIdAndDate($student['Student']['id'], $month[0]['date']);
      if ($absence_report) {
        $this->id = $absence_report['AbsenceReport']['id'];
        $this->set('percentage', $percentage);
        $this->save();
      } else {
        $this->create();
        $this->set('student_id', $student['Student']['id']);
        $this->set('date', $month[0]['date']);
        $this->set('percentage', $percentage);
        $this->save();
      }
    }
  }
}
