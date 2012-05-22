class Director::SchoolClassesController < ApplicationController

  before_filter :authenticate_director!

  def index
    @school_classes = current_director.active_school_classes
  end

end
