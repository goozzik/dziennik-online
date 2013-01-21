# coding: utf-8
class Director::SubjectsController < ApplicationController

  before_filter :authenticate_director!, :director_school_class_has_students?

  def show
    if params[:id]
      @subject = @school_class.subjects_active.find(params[:id])
    else
      @subject = @school_class.subjects_active.first
    end
    @descriptions = current_director.semester.descriptions.find_all_by_subject_id(@subject.id)
  end

end
