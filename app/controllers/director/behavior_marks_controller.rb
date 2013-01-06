class Director::BehaviorMarksController < ApplicationController

  before_filter :authenticate_director!, :director_school_class_has_students?

  def index
  end

end

