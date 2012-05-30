# coding: utf-8
class ApplicationController < ActionController::Base

  protect_from_forgery

  def current_teacher
    Teacher.find(current_user.id)
  end

  def current_director
    Director.find(current_user.id)
  end

  def current_student
    Student.find(current_user.id)
  end

  def current_admin
    Admin.find(current_user.id)
  end

  private

    # Overwriting the sign_in redirect path method
    def after_sign_in_path_for(resource_or_scope)
      root_path
    end

  protected

    def teacher_has_active_class?
      unless current_teacher.school_class
        flash[:alert] = "Najpierw dodaj klasę!"
        redirect_to teacher_school_classes_path
      end
    end

    def school_class_has_subjects?
      if current_teacher.school_class_subjects.empty?
        flash[:alert] = "Najpierw dodaj przedmioty!"
        redirect_to teacher_subjects_path
      end
    end

    def teacher_has_active_semester?
      unless current_teacher.school_class_semester
        flash[:alert] = "Najpierw ustaw semestr."
        redirect_to teacher_school_classes_path
      end
    end

    def school_class_has_students?
      if current_teacher.school_class_students.empty?
        flash[:alert] = "Najpierw dodaj uczniów!"
        redirect_to teacher_students_path
      end
    end

    def director_has_active_classes?
      if current_director.active_school_classes.empty?
        flash[:notice] = "Szkoła nie posiada aktywnych klas."
        redirect_to root_path
      end
    end

    def authenticate_superadmin!
      authenticate_user!
      redirect_to root_path unless current_user.superadmin
    end

    def authenticate_admin!
      authenticate_user!
      redirect_to root_path unless current_user.admin
    end

    def authenticate_director!
      authenticate_user!
      redirect_to root_path unless current_user.director
    end

    def authenticate_teacher!
      authenticate_user!
      redirect_to root_path unless current_user.teacher
    end

    def authenticate_student!
      authenticate_user!
      redirect_to root_path unless current_user.student
    end

end
