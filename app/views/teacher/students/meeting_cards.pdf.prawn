prawn_document do |pdf|
  @students.each do |student|
    table = [[{content: "#{student.first_name} #{student.last_name} - #{student.school_class_semester.fullname}", colspan:3}]]
    table << [{content: "Przedmiot", colspan:2}, "Oceny"]
    @subjects.each do |subject|
      table << [{content: subject.name, colspan:2}, student.list_current_marks_by_subject_id(subject.id)]
    end
    absences = student.current_absences
    table << [{content: "", colspan:3}]
    table << [{content: "nieobecnosci usprawiedliwione", colspan:2}, absences[:justified]]
    table << [{content: "nieobecnosci nieusprawiedliwione", colspan:2}, absences[:unexcused]]
    table << [{content: "spóźnienia", colspan:2}, absences[:late]]

    pdf.table(table, :width => 300)
    pdf.move_down 20
  end
end
