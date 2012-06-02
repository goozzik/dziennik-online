class Director::ReportsController < ApplicationController

  before_filter :authenticate_director!, :director_has_active_school_classes?

  def semestral
    @first_grade_school_classes = current_director.school_classes.active.grade(1)
    @second_grade_school_classes = current_director.school_classes.active.grade(2)
    @third_grade_school_classes = current_director.school_classes.active.grade(3)
    @fourth_grade_school_classes = current_director.school_classes.active.grade(4)
  end

  def school_class
    @school_classes = current_director.school_classes.active
    @school_class = current_director.school_classes.active.find_by_id(params[:school_class_id])
  end

end
