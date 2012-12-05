class Teacher::DescriptionsController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?, :school_class_has_active_semester?, :school_class_has_students?

  def create
    subject = current_teacher.subjects.find(params[:description][:subject_id])
    @description = subject.descriptions.build(params[:description])
    @description.save
    redirect_to :back
  end

  def destroy
    description = current_teacher.school_class.semester.descriptions.find(params[:id])
    subject = description.subject
    redirect_to teacher_subject_path(subject) if description.destroy
  end

end
