prawn_document do |pdf|
  students = [[]]
  @students.each_with_index do |student, i|
    students += [[i+1, student.first_name, student.last_name, "Login: " + student.username, "Hasło: " + student.username, "www.dziennik-online.pl"]]
  end

  pdf.table(students)
end
