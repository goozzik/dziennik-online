class Teacher::SubjectsController < ApplicationController

  def index
    @subjects = current_teacher.school_class.subjects
    @subject = Subject.new
  end

end
