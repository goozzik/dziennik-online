class Director::AbsencesController < ApplicationController

  def index
    @school_classes = current_director.active_school_classes
  end

end
