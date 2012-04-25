# coding: utf-8
module SemestersHelper

  # show whether semester object is active or not active
  def semester_status_info(semester)
    semester.active ? "#{semester.semester} - aktualnie wybrany" : semester.semester
  end

end
