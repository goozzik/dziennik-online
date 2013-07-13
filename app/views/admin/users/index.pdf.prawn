prawn_document do |pdf|
  pdf.text "Nauczyciele"
  pdf.move_down 5

  teachers = [[]]
  current_admin.teachers.each_with_index do |teacher, i|
    teachers += [[i+1, teacher.first_name, teacher.last_name, "Login: " + teacher.username, "Hasło: " + teacher.username, "www.dziennik-online.pl"]]
  end

  pdf.table(teachers)
end
