class Director::BehaviorMarksController < Director::DirectorController

  before_filter :director_school_class_has_students?

end
