class Teacher::TimeTablesController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?, :school_class_has_subjects?

  def index
    @time_table = TimeTable.new
    @time_tables = current_teacher.school_class.time_tables
    @days = current_teacher.school_class.available_time_table_days.collect { |i, day| [day, i] }
    @subjects = current_teacher.school_class.subjects.collect { |subject| [subject.name, subject.id] }
  end

  def create
    @time_table = current_teacher.school_class.time_tables.build(params[:time_table])
    @time_table.save ? redirect_to(:action => "index") : render(:action => "new")
    @days = current_teacher.school_class.available_time_table_days.collect { |i, day| [day, i] }
    @subjects = current_teacher.school_class.subjects.collect { |subject| [subject.name, subject.id] }
  end

  def destroy
    time_table = current_teacher.school_class.time_tables.find(params[:id])
    redirect_to :action => "index" if time_table.destroy
  end

end
