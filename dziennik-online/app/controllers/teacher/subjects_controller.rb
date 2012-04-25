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

  private

    def is_teacher_have_active_class?
      unless current_teacher.school_class
        flash[:notice] = "Najpierw dodaj klasę."
        redirect_to(:controller => "teacher/school_classes", :action => "index")
      end
    end

    def is_teacher_have_active_semester?
      unless current_teacher.semester
        flash[:notice] = "Najpierw dodaj semestr."
        redirect_to(:controller => "teacher/school_classes", :action => "index")
      end
    end

end
