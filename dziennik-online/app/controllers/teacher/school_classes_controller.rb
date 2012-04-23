class Teacher::SchoolClassesController < ApplicationController

  def index
    @school_classes = current_teacher.school_classes
    @school_class = current_teacher.school_classes.new
  end

end

