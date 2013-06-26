class Teacher::SemestersController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?

  def activate
    semester = current_teacher.semesters.find(params[:id])
    current_teacher.activate_semester(params[:id]) if semester
    redirect_to :controller => "school_classes", :action => "index"
  end

end
