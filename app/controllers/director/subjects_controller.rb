# coding: utf-8
class Director::SubjectsController < ApplicationController

  before_filter :authenticate_director!
  before_filter :school_class_has_students?, :subject_has_descriptions?

  def show
    @subjects = @school_class.subjects
    @students = @school_class.students
    #@semestral_marks = SemestralMark.find_all_by_students_and_semester_id_and_subject_id(@students, @semester.id, @subject.id)
  end

  private

    def school_class_has_students?
      @school_class = current_director.school_classes.find(params[:school_class_id]) 
      @students = @school_class.students
      if @students.empty?
        flash[:alert] = "Wychowawca klasy nie dodał jeszcze uczniów."
        redirect_to director_school_classes_path
      end
    end

    def subject_has_descriptions?
      @subject = @school_class.subjects.find(params[:id])
      @descriptions = @subject.descriptions.current
      if @descriptions.empty?
        flash[:alert] = "Wychowawca klasy nie dodał jeszcze ocen dla tego przedmiotu."
        redirect_to :back
      end
    end

end
