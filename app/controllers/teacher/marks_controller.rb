class Teacher::MarksController < ApplicationController

  before_filter :teacher_has_students?, :only => [:show]

  def update
    mark = current_teacher.semester.marks.find_by_description_id_and_student_id(params[:mark][:description_id], params[:mark][:student_id])
    if mark
      mark.update_attributes(params[:mark])
    else
      mark = current_teacher.semester.marks.build(params[:mark])
      mark.save
    end
  end

  def show
    @subject = current_teacher.school_class.subjects.find(params[:subject_id])
    @descriptions = current_teacher.semester.descriptions.where('subject_id = ' + params[:subject_id])
    @students = current_teacher.school_class.students
    @description = Description.new
    @marks = Mark.find_all_by_students_and_descriptions(@students, @descriptions)
    @semestral_marks = SemestralMark.find_all_by_students_and_semester_id_and_subject_id(@students, current_teacher.semester_id, @subject.id)
    @semester_id = current_teacher.semester_id
  end

end
