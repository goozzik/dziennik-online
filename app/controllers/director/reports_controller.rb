class Director::ReportsController < Director::DirectorController

  before_filter :school_has_active_semester?, :director_has_active_school_classes?

  def school_class
    @school_class = current_director.school_classes.find(params[:school_class_id])
  end

end
