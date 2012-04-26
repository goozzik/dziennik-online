# coding: utf-8
class Teacher::SubjectsController < ApplicationController

  before_filter :is_teacher_have_active_class?, :is_teacher_have_active_semester?, :only => [:index]

  def index
    @subjects = current_teacher.school_class.subjects
    @subject = Subject.new
  end

  def create
    @subject = current_teacher.school_class.subjects.build(params[:subject])
    @subject.save ? redirect_to(:controller => "teacher/subjects", :action => "index") : render(:action => "index")
  end

  def show
    @subject = current_teacher.school_class.subjects.find(params[:id])
    @descriptions = current_teacher.semester.descriptions.where('subject_id = ' + params[:id])
    @students = current_teacher.school_class.students
    @description = Description.new
#    @marks = []
#    @students.each_with_index do |student, i|
#      @marks[i] = []
#      @descriptions.each_with_index do |description, j|
#        @marks[i][j] = Mark.find_by_student_id_and_description_id(student.id, description.id)
#      end
#    end
  end

end
