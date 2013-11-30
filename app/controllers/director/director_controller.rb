#coding: utf-8
class Director::DirectorController < ApplicationController

  before_filter :authenticate_director!

  private

    def authenticate_director!
      authenticate_user!
      redirect_to root_path unless current_user.director?
    end

    def director_school_class_has_students?
      @school_class = current_director.school_classes.find(params[:school_class_id])
      if @school_class.students.empty?
        flash[:alert] = "Wychowawca klasy nie dodał jeszcze uczniów."
        redirect_to :back
      end
    end

    def director_has_active_school_classes?
      if current_director.school_classes.active.empty?
        flash[:alert] = "Szkoła nie posiada aktywnych klas."
        redirect_to root_path
      end
    end

end
