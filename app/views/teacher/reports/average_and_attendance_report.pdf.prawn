prawn_document(:margin => 0) do |pdf|
  pdf.font "#{Prawn::DATADIR}/fonts/DejaVuSans.ttf"
  pdf.font_size 8

  table = [["#", "Imię", "Nazwisko", "Średnia", "Frekwencja"]]
  current_teacher.students_by_average(@semester).each_with_index do |student, i|
    semester_absences = student.semester_absences(@semester)
    table << [i+1, student.first_name, student.last_name, student.average_semestral_mark_for_semester(@semester), semester_absences.percentage]
  end

  pdf.table(table, column_widths: [30, 140, 145, 140, 140], position: 8)

end
