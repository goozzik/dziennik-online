class Director::ReportsController < Director::DirectorController

  before_filter :school_has_active_semester?, :director_has_active_school_classes?

end
