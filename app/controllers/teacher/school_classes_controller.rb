class Teacher::SchoolClassesController < ApplicationController

  before_filter :authenticate_teacher!

  def index
    @active_school_class = current_teacher.school_class
    @school_class = current_teacher.school_classes.new
    @school_classes = current_teacher.school_classes
  end

  def new
    @school_class = current_teacher.school_classes.new
  end

  def create
    @school_class = current_teacher.school_classes.build(params[:school_class])
    @school_class.save ? redirect_to(:action => "index") : render(:action => "new")
  end

  def destroy
    school_class = current_teacher.school_classes.find(params[:id])
    redirect_to(:action => "index") if school_class.destroy
  end

  def activate
    school_class = current_teacher.school_classes.find(params[:id])
    school_class.activate
    redirect_to :action => "index"
  end

end
