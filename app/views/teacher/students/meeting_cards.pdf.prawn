prawn_document(:margin => 0) do |pdf|
  pdf.font_size 8
  rows_count = current_teacher.subjects.count < 17 ? 2 : 1
  pdf.define_grid(columns: 2, rows: rows_count)

  current_teacher.students.each_with_index do |student, i|
    table = [[{content: "#{student.first_name} #{student.last_name} - #{current_teacher.semester_fullname}", colspan:10}]]
    table << [{content: "Przedmiot", colspan:4}, {content: "Oceny", colspan:5}, "OS"]
    current_teacher.subjects.each do |subject|
      semestral_mark = student.semestral_marks.find_by_subject_id_and_semester_id(subject, current_teacher.semester)
      table << [{content: truncate(subject.name, length: 30), colspan:4}, {content: student.list_current_marks_by_subject_id(subject.id), colspan:5}, semestral_mark ? semestral_mark.mark : ""]
    end

    absences = student.current_absences
    behavior_mark = student.current_semester_behavior_mark

    table << [{content: "nieobecnosci usprawiedliwione: #{absences.justified}, nieobecnosci nieusprawiedliwione: #{absences.unexcused}, spóźnienia: #{absences.late}, frekwencja: #{absences.percentage}%" + (behavior_mark ? ", zachowanie: #{behavior_mark.mark}" : ""), colspan:10}]

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
