class Teacher::SemestersController < ApplicationController

  def create
    @semester = current_teacher.semesters.build(params[:semester])
    @semester.save ? redirect_to(:controller => "school_classes", :action => "index") : render(:action => "index")
  end

end
