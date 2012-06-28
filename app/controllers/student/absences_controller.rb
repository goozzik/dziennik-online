class Student::AbsencesController < ApplicationController

  before_filter :authenticate_student!

  def index
    @student = current_student
    @absences = current_student.absences.where(["semester_id = ?", current_student.school_class.semester_id])
  end

end
