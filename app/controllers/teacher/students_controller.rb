class Teacher::StudentsController < ApplicationController

  before_filter :teacher_has_active_class?, :only => [:index]

  def index
    @students = current_teacher.school_class.students
    @student = Student.new
  end

  def create
    @student = current_teacher.school_class.students.build(params[:student])
    @student.save ? redirect_to(:controller => "teacher/students", :action => "index") : render(:action => "index")
  end

end
