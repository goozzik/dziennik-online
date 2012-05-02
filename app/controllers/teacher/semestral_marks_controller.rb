class Teacher::SemestralMarksController < ApplicationController

  def update
    semestral_mark = current_teacher.semester.semestral_marks.find_by_subject_id_and_student_id(params[:semestral_mark][:subject_id], params[:semestral_mark][:student_id])
    if semestral_mark
      semestral_mark.update_attributes(params[:semestral_mark])
    else
      semestral_mark = current_teacher.semester.semestral_marks.build(params[:semestral_mark])
      semestral_mark.save
    end
  end

end
