class Teacher::DescriptionsController < ApplicationController

  before_filter :authenticate_teacher!

  def create
    @description = current_teacher.school_class.subjects.find(params[:description][:subject_id]).descriptions.build(params[:description])
    @description.save ? redirect_to(:back) : render(:action => "new")
  end

  def destroy
    description = current_teacher.semester.descriptions.find(params[:id])
    subject_id = description.subject_id
    description.destroy
    redirect_to(:controller => "teacher/subject", :action => "show", :subject_id => subject_id)
  end

end
