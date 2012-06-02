class Student::TimeTablesController < ApplicationController

  before_filter :authenticate_student!

  def index
    @time_tables = current_student.school_class.time_tables
  end

end
