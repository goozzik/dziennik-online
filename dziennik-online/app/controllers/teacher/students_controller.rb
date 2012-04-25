class Teacher::StudentsController < ApplicationController

  before_filter :is_teacher_have_active_class?, :only => [:index]

  def index
    @students = current_teacher.school_class.students
  end

end
