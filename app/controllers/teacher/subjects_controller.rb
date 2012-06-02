# coding: utf-8
class Teacher::SubjectsController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?, :school_class_has_active_semester?
  before_filter :school_class_has_students?, :only => [:show]

  def index
    @subject = Subject.new
    @subjects = current_teacher.school_class.subjects
    @subject_templates = current_teacher.school_class.available_subject_templates
  end

  def show
    @description = Description.new
    @subject = current_teacher.school_class.subjects.find(params[:id])
    @descriptions = current_teacher.school_class.semester.descriptions.find_all_by_subject_id(@subject.id)
    @students = current_teacher.school_class.students
  end

  def create
    @subject_templates = current_teacher.school_class.available_subject_templates
    @subject = current_teacher.school_class.subjects.build(params[:subject])
    @subject.save ? redirect_to(:action => "index") : render(:action => "new")
  end

  def destroy
    subject = current_teacher.school_class.subjects.find(params[:id])
    redirect_to teacher_subjects_path if subject.destroy
  end

end
