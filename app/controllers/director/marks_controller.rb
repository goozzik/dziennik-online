class Director::MarksController < ApplicationController

  before_filter :authenticate_director!

  def index
    @school_class = current_director.school.school_classes.find(params[:school_class_id])
    @semester = @school_class.semester
    @subject = if params[:subject_id].nil?
      @school_class.subjects.first
    else
      @school_class.subjects.find(params[:subject_id])
    end
    @students = @school_class.students
    @descriptions = @subject.descriptions.find_all_by_semester_id(@semester.id)
    @marks = Mark.find_all_by_students_and_descriptions(@students, @descriptions)
    @semestral_marks = SemestralMark.find_all_by_students_and_semester_id_and_subject_id(@students, @semester.id, @subject.id)
  end

end
