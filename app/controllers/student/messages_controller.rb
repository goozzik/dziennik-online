class Student::MessagesController < ApplicationController

  before_filter :authenticate_student!

  def index
  end

end
