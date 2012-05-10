# coding: utf-8
class Teacher::SubjectsController < ApplicationController

  before_filter :teacher_has_active_class?, :teacher_has_active_semester?, :only => [:index, :show]

  def index
    @subjects = current_teacher.school_class.subjects
    @subject = Subject.new
  end

  def create
    @subject = current_teacher.school_class.subjects.build(params[:subject])
    @subject.save ? redirect_to(:controller => "teacher/subjects", :action => "index") : render(:action => "index")
  end

end
