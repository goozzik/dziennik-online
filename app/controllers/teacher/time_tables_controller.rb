class Teacher::TimeTablesController < ApplicationController

  before_filter :teacher_has_active_class?, :only => [:index]

  def index
    @time_tables = current_teacher.school_class.time_tables
  end

  def new
    @time_table = TimeTable.new
    @days = current_teacher.school_class.available_time_table_days
    @subjects = current_teacher.school_class.subjects.collect { |subject| [subject.name, subject.id] }
  end

  def create
    @time_table = current_teacher.school_class.time_tables.build(params[:time_table])
    @time_table.save ? redirect_to(:controller => "teacher/time_tables", :action => "index") : render(:action => "new")
  end

  def destroy
    time_table = current_teacher.school_class.time_tables.find(params[:id])
    time_table.destroy
    redirect_to(:controller => "teacher/time_tables", :action => "index")
  end

end
