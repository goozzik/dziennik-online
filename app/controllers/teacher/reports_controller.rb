class Teacher::ReportsController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?, :school_class_has_active_semester?, :school_class_has_students?

  def index
  end

  def average_and_attendance_report
    @semester = Semester.find(params[:semester_id])
  end

end
