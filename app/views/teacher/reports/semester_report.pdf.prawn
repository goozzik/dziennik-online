prawn_document(:margin => 0) do |pdf|
  pdf.font "#{Prawn::DATADIR}/fonts/DejaVuSans.ttf"
  pdf.font_size 8

  pdf.move_down 10
  pdf.draw_text "#{current_teacher.school_class.fullname}, #{@semester.fullname}", at: [10, 780]
  pdf.move_down 10

  table = [[{content: "#", rowspan: 2},
            {content: "Imię", rowspan: 2},
            {content: "Nazwisko", rowspan: 2},
            {content: "Frekwencja", colspan: 5},
            {content: "Oceny", colspan: 8}]]

  table << ["%", "ob", "us", "nu", "sp", "Średnia", "1", "2", "3", "4", "5", "6", "nkl"]

  current_teacher.students.each_with_index do |student, i|
    semester_absences = student.semester_absences(@semester)
    table << [i+1, student.first_name, student.last_name,
              semester_absences.percentage, semester_absences.required,
              semester_absences.justified, semester_absences.unexcused,
              semester_absences.late, student.average_semestral_mark_for_semester(@semester),
              student.count_semestral_marks(1, @semester.id),
              student.count_semestral_marks(2, @semester.id),
              student.count_semestral_marks(3, @semester.id),
              student.count_semestral_marks(4, @semester.id),
              student.count_semestral_marks(5, @semester.id),
              student.count_semestral_marks(6, @semester.id),
              student.count_semestral_marks("nkl", @semester.id)]
  end

  school_class = current_teacher.school_class
  semester_absences = school_class.semester_absences(@semester)

  table << [{content: "Razem", colspan: 3},
            semester_absences.percentage,
            semester_absences.required,
            semester_absences.justified,
            semester_absences.unexcused,
            semester_absences.late,
            school_class.average_semestral_mark_for_semester(@semester),
            school_class.count_semestral_marks(1, @semester.id),
            school_class.count_semestral_marks(2, @semester.id),
            school_class.count_semestral_marks(3, @semester.id),
            school_class.count_semestral_marks(4, @semester.id),
            school_class.count_semestral_marks(5, @semester.id),
            school_class.count_semestral_marks(6, @semester.id),
            school_class.count_semestral_marks("nkl", @semester.id)]

  pdf.table(table, column_widths: [30, 80, 80, 40, 25, 25, 25, 25, 40, 25, 25, 25, 25, 25, 25], position: 10)

end
