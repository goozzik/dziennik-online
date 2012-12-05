# coding: utf-8
class Teacher::SubjectsController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?, :school_class_has_active_semester?
  before_filter :school_class_has_students?, :only => [:show]

  def show
    @description = Description.new
    @subject = current_teacher.subjects.find(params[:id])
    @descriptions = current_teacher.school_class.semester.descriptions.find_all_by_subject_id(@subject.id)
    @students = current_teacher.school_class.students
  end

end
