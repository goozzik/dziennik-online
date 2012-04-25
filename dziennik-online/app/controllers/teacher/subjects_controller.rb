class Teacher::SubjectsController < ApplicationController

  def index
    @subjects = current_teacher.school_class.subjects
    @subject = Subject.new
  end

  def create
    @subject = current_teacher.school_class.subjects.build(params[:subject])
    @subject.save ? redirect_to(:controller => "subjects", :action => "index") : render(:action => "index")
  end

end
