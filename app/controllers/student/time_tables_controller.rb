class Student::TimeTablesController < ApplicationController

  before_filter :authenticate_student!

  def index
  end

end
