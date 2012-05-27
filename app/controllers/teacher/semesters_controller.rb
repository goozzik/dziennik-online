class Teacher::SemestersController < ApplicationController

  before_filter :authenticate_teacher!

  def create
    @semester = current_teacher.school_classes.find(params[:semester][:school_class_id]).semesters.build(params[:semester])
    @semester.save ? redirect_to(:controller => "school_classes", :action => "index") : render(:action => "index")
  end

  def destroy
    @semester = current_teacher.semesters.find(params[:id])
    @semester.destroy
    redirect_to(:controller => "school_classes", :action => "index")
  end

  def activate
    semester = current_teacher.semesters.find(params[:id])
    semester.activate
    redirect_to(:controller => "school_classes", :action => "index")
  end

end
