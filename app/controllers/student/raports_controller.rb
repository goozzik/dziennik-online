class Student::RaportsController < ApplicationController

  before_filter :authenticate_student!

  def index
    @semesters = current_teacher.school_class_semesters
    @students = current_teacher.school_class_students
    @school_class = current_teacher.school_class
  end

end
