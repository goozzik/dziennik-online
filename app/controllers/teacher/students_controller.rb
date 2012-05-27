class Teacher::StudentsController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?

  def index
    @student = current_teacher.school_class_students.new
    @students = current_teacher.school_class_students
  end

  def show
    @student = current_teacher.school_class_students.find(params[:id])
  end

  def new
    @student = current_teacher.school_class_students.new
  end

  def edit
    @student = current_teacher.school_class_students.find(params[:id])
  end

  def create
    @student = current_teacher.school_class_students.build(params[:student])
    @student.save ? redirect_to(:action => "index") : render(:action => "new")
  end

  def update
    @student = current_teacher.school_class_students.find(params[:id])
    @student.update_attributes(params[:student]) ? redirect_to(:action => "index") : render(:action => "edit")
  end

  def destroy
    student = current_teacher.school_class_students.find(params[:id])
    redirect_to(:action => "index") if student.destroy
  end

  def new_password
    @student = current_teacher.school_class_students.find(params[:id])
  end

  def update_password
    @student = current_teacher.school_class_students.find(params[:id])
    @student.update_password(params[:student]) ? redirect_to(:action => "index") : render(:action => "new_password")
  end

end
