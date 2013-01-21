class Director::AbsencesController < ApplicationController

  before_filter :authenticate_director!, :director_school_class_has_students?

  def index
    @month = params[:month].nil? ? Time.now.month : params[:month]
  end

end
