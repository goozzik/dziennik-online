class Director::ReportsController < ApplicationController

  before_filter :authenticate_director!,
                :school_has_active_semester?,
                :director_has_active_school_classes?

  def absences
  end

  def school_class
    @school_class = current_director.school_classes.find(params[:school_class_id])
  end

end
