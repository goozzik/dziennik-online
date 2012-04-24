class Teacher::SemestersController < ApplicationController

  def create
    @semester = current_teacher.semesters.build(params[:semester])
    @semester.save ? redirect_to(:controller => "school_classes", :action => "index") : render(:action => "index")
  end

  def destroy
    @semester = Semester.find(params[:id])
    @semester.destroy
    redirect_to :controller => "school_classes", :action => "index"
  end

  def activate
    @semester = Semester.find(params[:id])
    @semester.activate
    redirect_to :controller => "school_classes", :action => "index"
  end

end
