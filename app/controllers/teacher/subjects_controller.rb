# coding: utf-8
class Teacher::SubjectsController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?, :teacher_has_active_semester?, :only => [:index, :show]
  before_filter :teacher_has_students?, :only => [:show]


  def index
    @subjects = current_teacher.school_class_subjects
    @subject = Subject.new
  end

  def create
    subject = current_teacher.school_class_subjects.build(params[:subject])
    subject.save ? redirect_to(:action => "index") : render(:action => "new")
  end

  def show
    @subject = current_teacher.school_class_subjects.find(params[:id])
    @descriptions = current_teacher.semester_descriptions.where('subject_id = ' + params[:id])
    @students = current_teacher.school_class_students
    @description = Description.new
    @marks = Mark.find_all_by_students_and_descriptions(@students, @descriptions)
    @semestral_marks = SemestralMark.find_all_by_students_and_semester_id_and_subject_id(@students, current_teacher.semester_id, @subject.id)
    @semester_id = current_teacher.semester_id
  end

  def destroy
    subject = current_teacher.school_class_subjects.find(params[:id])
    redirect_to teacher_subjects_path if subject.destroy
  end

end
