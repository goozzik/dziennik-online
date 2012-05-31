class Teacher::SemestersController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?

  def activate
    semester = current_teacher.school_semesters.find(params[:id])
    current_teacher.school_class_activate_semester(semester) if semester
    redirect_to :controller => "school_classes", :action => "index"
  end

end
