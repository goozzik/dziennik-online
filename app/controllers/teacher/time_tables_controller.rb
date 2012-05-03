class Teacher::TimeTablesController < ApplicationController

  before_filter :teacher_has_active_class?, :only => [:index]

  def index
    @time_tables = current_teacher.school_class.time_tables
  end

end
