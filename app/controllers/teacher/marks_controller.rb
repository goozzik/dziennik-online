class Teacher::MarksController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?, :school_class_has_active_semester?, :school_class_has_students?

  def update
    subject = current_teacher.school_class_subjects.find(params[:subject_id])
    description = subject.descriptions.find(params[:mark][:description_id])
    mark = description.marks.find_by_student_id(params[:mark][:student_id])
    if mark
      mark.update_attribute(:mark, params[:mark][:mark])
    else
      mark = Mark.new(params[:mark])
      mark.save
    end
    redirect_to teacher_subjects_path
  end

end
