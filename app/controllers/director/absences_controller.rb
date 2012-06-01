class Director::AbsencesController < ApplicationController

  before_filter :authenticate_director!
  before_filter :director_has_active_classes?

  def index
    @school_class = current_director.school_classes.find(params[:school_class_id])
    @semester = @school_class.semesters.find(params[:semester_id])
    @students = @school_class.students
    @semesters = @school_class.semesters
  end

  def actual
    @month = Chronic.parse('monday this month', :now => (params[:date].nil? ? Time.now : Time.parse(params[:date])))
    @weeks = Absence.get_weeks_from_month(@month)
    @students = current_director.school.school_classes.find(params[:school_class_id]).students
    @absences = Absence.find_all_by_students_and_dates(@students, @weeks)
    @previous_month = Chronic.parse('monday last month', :now => @month)
    @next_month = Chronic.parse('monday next month', :now => @month)
  end

end
