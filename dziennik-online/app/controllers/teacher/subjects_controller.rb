class Teacher::SubjectsController < ApplicationController

  def index
    @subjects = current_teacher.school_class.subjects
  end

end
