class Student::MessagesController < ApplicationController

  before_filter :authenticate_student!

  def index
    @messages = current_student.messages
  end

end
