# coding: utf-8
class ApplicationController < ActionController::Base

  protect_from_forgery

  def current_teacher
    Teacher.find(current_user.id)
  end

  private

    # Overwriting the sign_in redirect path method
    def after_sign_in_path_for(resource_or_scope)
      root_path
    end

  protected

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
