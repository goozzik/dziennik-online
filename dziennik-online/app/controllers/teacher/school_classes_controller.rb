class Teacher::SchoolClassesController < ApplicationController

  def index
    @school_classes = current_teacher.school_classes
    @school_class = current_teacher.school_classes.new
    @semester = Semester.new
  end

  def create
    @school_class = current_teacher.school_classes.build(params[:school_class])
    @school_class.save ? redirect_to(:action => "index") : render(:action => "index")
  end

end

