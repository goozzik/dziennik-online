# coding: utf-8
class ApplicationController < ActionController::Base

  protect_from_forgery

  def current_teacher
    Teacher.find(current_user.id)
  end

  def current_director
    Director.find(current_user.id)
  end

  private

    # Overwriting the sign_in redirect path method
    def after_sign_in_path_for(resource_or_scope)
      root_path
    end

  protected

    def teacher_has_active_class?
      unless current_teacher.school_class
        flash[:notice] = "Najpierw dodaj klasę."
        redirect_to(:controller => "teacher/school_classes", :action => "index")
      end
    end

    def teacher_has_active_semester?
      unless current_teacher.semester
        flash[:notice] = "Najpierw dodaj semestr."
        redirect_to(:controller => "teacher/school_classes", :action => "index")
      end
    end

    def teacher_has_students?
      if current_teacher.school_class.students.empty?
        flash[:notice] = "Najpierw dodaj uczniów."
        redirect_to(:controller => "teacher/students", :action => "index")
      end
    end

    def director_has_active_classes?
      if current_director.active_school_classes.empty?
        flash[:notice] = "Szkoła nie ma żadnych aktywnych klas."
        redirect_to(root_path)
      end
    end

end
