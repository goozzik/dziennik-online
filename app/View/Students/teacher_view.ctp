<?php if (empty($student)): ?>
  <ul><li>Wystąpił błąd, gdyż wybrany uczeń nie istnieje.</li></ul>
<?php else: ?>

<?php print_r($student);?>

<?php endif?>