class Director::MarksController < ApplicationController

  def index
    @school_class = current_director.school.school_classes.find(params[:school_class_id])
    @semester = @school_class.semester
    @subject = params[:subject_id].nil? ? @school_class.subjects.first : @school_class.subjects.find(params[:subject_id])
    @descriptions = @semester.descriptions.find_all_by_subject_id(@subject.id)
    @students = @school_class.students
    @marks = Mark.find_all_by_students_and_descriptions(@students, @descriptions)
    @semestral_marks = SemestralMark.find_all_by_students_and_semester_id_and_subject_id(@students, @semester.id, @subject.id)
  end

end
