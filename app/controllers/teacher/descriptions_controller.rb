class Teacher::DescriptionsController < ApplicationController

  def create
    @description = current_teacher.school_class.subjects.find(params[:description][:subject_id]).descriptions.build(params[:description])
    @description.save ? redirect_to(:back) : render(:action => "new")
  end

end
