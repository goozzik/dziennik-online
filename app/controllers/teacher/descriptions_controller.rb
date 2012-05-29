class Teacher::DescriptionsController < ApplicationController

  before_filter :authenticate_teacher!

  def create
    subject = current_teacher.school_class_subjects.find(params[:description][:subject_id])
    @description = subject.descriptions.build(params[:description])
    @description.save ? redirect_to(:back) : render(:action => "new")
  end

  def destroy
    description = current_teacher.semester.descriptions.find(params[:id])
    subject = description.subject
    redirect_to teacher_subject_path(subject) if description.destroy
  end

end
