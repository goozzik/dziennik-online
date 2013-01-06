class Teacher::SemestralMarksController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?, :school_class_has_active_semester?, :school_class_has_students?

  def update
    subject = current_teacher.subjects.find(params[:semestral_mark][:subject_id])
    student = current_teacher.students.find(params[:semestral_mark][:student_id])
    semestral_mark = current_teacher.semester.semestral_marks.first(:conditions => ['subject_id = ? AND student_id = ?', subject.id, student.id])
    if semestral_mark
      old_mark = semestral_mark.mark
      if params[:semestral_mark][:mark] == "0"
        semestral_mark.destroy
        render js: "$('#semestral_mark_#{params[:semestral_mark][:student_id]}').html('');"
      else
        if semestral_mark.update_attributes(params[:semestral_mark])
          render js: "$('#semestral_mark_#{params[:semestral_mark][:student_id]}').html('#{semestral_mark.mark}');"
        else
          render js: "$('#semestral_mark_#{params[:semestral_mark][:student_id]}').html('#{old_mark}');"
        end
      end
    else
      if SemestralMark.create(params[:semestral_mark])
        render js: "$('#semestral_mark_#{params[:semestral_mark][:student_id]}').html('#{params[:semestral_mark][:mark]}');"
      else
        render js: "$('#semestral_mark_#{params[:semestral_mark][:student_id]}').html('');"
      end
    end
  end

end
