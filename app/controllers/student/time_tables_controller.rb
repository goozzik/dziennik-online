class Student::TimeTablesController < ApplicationController

  before_filter :authenticate_student!

  def index
    @time_tables = current_student.time_tables
  end

end
