# coding: utf-8
class Teacher::SubjectsController < ApplicationController

  before_filter :teacher_has_active_class?, :teacher_has_active_semester?, :only => [:index]

  def index
    @subjects = current_teacher.school_class.subjects
    @subject = Subject.new
  end

  def create
    @subject = current_teacher.school_class.subjects.build(params[:subject])
    @subject.save ? redirect_to(:controller => "teacher/subjects", :action => "index") : render(:action => "index")
  end

  def show
    @subject = current_teacher.school_class.subjects.find(params[:id])
    @descriptions = current_teacher.semester.descriptions.where('subject_id = ' + params[:id])
    @students = current_teacher.school_class.students
    @description = Description.new
    @marks = Mark.find_all_by_students_and_descriptions(@students, @descriptions)
    @semestral_marks = SemestralMark.find_all_by_students_and_semester_id_and_subject_id(@students, current_teacher.semester_id, @subject.id)
  end

end
