# coding: utf-8
class Teacher::SubjectsController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?, :school_class_has_active_semester?, :school_class_has_students?

  def show
    @subject = current_teacher.subjects.find(params[:id])
    @descriptions = current_teacher.semester.descriptions.find_all_by_subject_id(@subject.id)
  end

end
