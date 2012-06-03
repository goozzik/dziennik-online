# coding: utf-8
class Director::StudentsController < ApplicationController

  before_filter :authenticate_director!
  before_filter :school_has_subject_templates?, only: [:resit, :classification]

  def top
    @first_grade_students = current_director.school.best_students_by_grade(1)
    @second_grade_students = current_director.school.best_students_by_grade(2)
    @third_grade_students = current_director.school.best_students_by_grade(3)
    @fourth_grade_students = current_director.school.best_students_by_grade(4)
  end

  def resit
    @school = current_director.school
  end

  def classification
    @school = current_director.school
  end

  private

    def school_has_subject_templates?
      @subject_templates = current_director.school.subject_templates
      if @subject_templates.empty?
        flash[:alert] = "Wychowawcy klas nie dodali jeszcze przedmiotów."
        redirect_to :back
      end
    end

end
