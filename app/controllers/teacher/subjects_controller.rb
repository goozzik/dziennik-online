# coding: utf-8
class Teacher::SubjectsController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?, :teacher_has_active_semester?, :only => [:index, :show, :new]
  before_filter :teacher_has_students?, :only => [:show]

  def index
    @subject = current_teacher.school_class_subjects.new
    @subjects = current_teacher.school_class_subjects
    @subject_templates = current_teacher.school_class_available_subject_templates
  end

  def show
    @description = Description.new
    @subject = current_teacher.school_class_subjects.find(params[:id])
    @descriptions = current_teacher.school_class_semester_descriptions.find_all_by_subject_id(@subject.id)
    @students = current_teacher.school_class_students
    @marks = Mark.find_all_by_students_and_descriptions(@students, @descriptions)
    @semestral_marks = SemestralMark.find_all_by_students_and_semester_id_and_subject_id(@students, current_teacher.school_class_semester.id, @subject.id)
  end

  def create
    @subject_templates = current_teacher.school_class_available_subject_templates
    @subject = current_teacher.school_class_subjects.build(params[:subject])
    @subject.save ? redirect_to(:action => "index") : render(:action => "new")
  end

  def destroy
    subject = current_teacher.school_class_subjects.find(params[:id])
    redirect_to teacher_subjects_path if subject.destroy
  end

end
