class Teacher::MarksController < ApplicationController

  before_filter :authenticate_teacher!

  def update
    mark = current_teacher.school_class_semester_marks.find_by_description_id_and_student_id(params[:mark][:description_id], params[:mark][:student_id])
    if mark
      mark.update_attributes(params[:mark])
    else
      mark = current_teacher.school_class_semester_marks.build(params[:mark])
      mark.save
    end
    redirect_to teacher_subjects_path
  end

end
