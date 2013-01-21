class Director::SchoolClassesController < ApplicationController

  before_filter :authenticate_director!

  def index
  end

end
