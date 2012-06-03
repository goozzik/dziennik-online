class Teacher::SemestralMarksController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?, :school_class_has_active_semester?, :school_class_has_students?

  def update
    subject = current_teacher.school_class.subjects.find(params[:semestral_mark][:subject_id])
    student = current_teacher.school_class.students.find(params[:semestral_mark][:student_id])
    semestral_mark = current_teacher.school_class.semester.semestral_marks.first(:conditions => ['subject_id = ? AND student_id = ?', subject.id, student.id])
    semestral_mark ? semestral_mark.update_attributes(params[:semestral_mark]) : SemestralMark.create(params[:semestral_mark])
  end

end
