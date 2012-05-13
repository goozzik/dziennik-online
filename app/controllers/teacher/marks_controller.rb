class Teacher::MarksController < ApplicationController

  def update
    mark = current_teacher.semester.marks.find_by_description_id_and_student_id(params[:mark][:description_id], params[:mark][:student_id])
    if mark
      mark.update_attributes(params[:mark])
    else
      mark = current_teacher.semester.marks.build(params[:mark])
      mark.save
    end
    redirect_to teacjer_subjects_path
  end

end
