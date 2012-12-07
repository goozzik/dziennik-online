prawn_document(:margin => 0) do |pdf|
  pdf.font_size 8
  rows_count = current_teacher.subjects.count < 17 ? 2 : 1
  pdf.define_grid(columns: 2, rows: rows_count)

  current_teacher.students.each_with_index do |student, i|
    table = [[{content: "#{student.first_name} #{student.last_name} - #{current_teacher.semester_fullname}", colspan:3}]]
    table << [{content: "Przedmiot", colspan:2}, "Oceny"]
    current_teacher.subjects.each do |subject|
      table << [{content: truncate(subject.name, length: 50), colspan:2}, student.list_current_marks_by_subject_id(subject.id)]
    end
    absences = student.current_absences
    table << [{content: "nieobecnosci usprawiedliwione: #{absences.justified}, nieobecnosci nieusprawiedliwione: #{absences.unexcused}, spóźnienia: #{absences.late}, frekwencja: #{absences.percentage}%", colspan:3}]

    if rows_count == 2
      pdf.start_new_page if (i % 4 == 0 && i != 0)
    else
      pdf.start_new_page if (i % 2 == 0 && i != 0)
    end

    grid_x = if rows_count == 2
      (i % 4 == 0 || i % 4 == 1) ? 0 : 1
    else
      0
    end

    grid_y = i % 2 == 0 ? 0 : 1

    pdf.grid(grid_x, grid_y).bounding_box do
      pdf.table(table)
    end
  end

end
