class Director::SchoolClassesController < ApplicationController

  before_filter :director_has_active_classes?, :only => [:index]

  def index
    @school_classes = current_director.active_school_classes
  end

end
