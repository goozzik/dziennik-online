class Teacher::SemestralMarksController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?, :school_class_has_active_semester?, :school_class_has_students?

  def update
    subject = current_teacher.school_class_subjects.find(params[:semestral_mark][:subject_id])
    student = current_teacher.school_class_students.find(params[:semestral_mark][:student_id])
    semestral_mark = current_teacher.school_class_semester_semestral_marks.first(:conditions => ['subject_id = ? AND student_id = ?', subject.id, student.id])
    if semestral_mark
      semestral_mark.update_attribute(:mark, params[:semestral_mark][:mark])
    else
      semestral_mark = SemestralMark.new(params[:semestral_mark])
      semestral_mark.save
    end
  end

end
