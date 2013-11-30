class Director::AbsencesController < Director::DirectorController

  before_filter :director_school_class_has_students?

  def index
    @month = params[:month].nil? ? Time.now.month : params[:month]
  end

end
