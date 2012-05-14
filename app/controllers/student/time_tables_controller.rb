class Student::TimeTablesController < ApplicationController

  def index
    @time_tables = current_student.time_tables
  end

end
