class Teacher::StudentsController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?, :only => [:index]

  def index
    @students = current_teacher.school_class.students
    @student = Student.new
  end

  def create
    @student = current_teacher.school_class.students.build(params[:student])
    @student.save ? redirect_to(:action => "index") : render(:action => "new")
  end

  def destroy
    student = current_teacher.school_class.students.find(params[:id])
    student.destroy
    redirect_to(:controller => "teacher/students", :action => "index")
  end

  def show
    @student = current_teacher.school_class.students.find(params[:id])
  end

  def edit
    @student = current_teacher.school_class.students.find(params[:id])
  end

  def update
    @student = current_teacher.school_class.students.find(params[:id])
    if @student.update_attributes(params[:student])
      redirect_to :action => "index"
    else
      render :action => "index"
    end
  end

end
