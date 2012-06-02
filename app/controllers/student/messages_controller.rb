class Student::MessagesController < ApplicationController

  before_filter :authenticate_student!

  def index
    @messages = current_student.school_class.messages
  end

end
