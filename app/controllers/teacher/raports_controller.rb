class Teacher::RaportsController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?, :school_class_has_active_semester?, :school_class_has_students?

  def index
    @semesters = current_teacher.school_class_semesters
    @students = current_teacher.school_class_students
    @school_class = current_teacher.school_class
  end

end
