class Director::ReportsController < ApplicationController

  before_filter :authenticate_director!, :director_has_active_school_classes?

  def index
    @first_grade_school_classes = current_director.school_classes.active.grade(1)
    @second_grade_school_classes = current_director.school_classes.active.grade(2)
    @third_grade_school_classes = current_director.school_classes.active.grade(3)
    @fourth_grade_school_classes = current_director.school_classes.active.grade(4)
  end

end
