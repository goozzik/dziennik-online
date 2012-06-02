# coding: utf-8
class Director::SubjectsController < ApplicationController

  before_filter :authenticate_director!
  before_filter :director_school_class_has_students?, :director_school_class_has_subjects?

  def show
    if params[:id]
      @subject = @school_class.subjects.find(params[:id])
    else
      @subject = @school_class.subjects.first
    end
    @descriptions = @subject.descriptions
  end

  private

    def director_school_class_has_subjects?
      @subjects = @school_class.subjects
      if @subjects.empty?
        flash[:alert] = "Wychowawca klasy nie dodał jeszcze przedmiotów."
        redirect_to :back
      end
    end

end
