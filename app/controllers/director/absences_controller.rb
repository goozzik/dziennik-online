class Director::AbsencesController < ApplicationController

  before_filter :director_has_active_classes?, :only => [:index, :actual]

  def index
    @school_classes = current_director.active_school_classes
  end

  def actual
    @month = Chronic.parse('monday this month', :now => (params[:date].nil? ? Time.now : Time.parse(params[:date])))
    @weeks = Absence.get_weeks_from_month(@month)
    @students = current_director.school.school_classes.find(params[:school_class_id]).students
    @absences = Absence.find_all_by_students_and_dates(@students, @weeks)
    @previous_month = Chronic.parse('monday last month', :now => @month)
    @next_month = Chronic.parse('monday next month', :now => @month)
  end

  def general
    school_class = current_director.school.school_classes.find(params[:school_class_id])
    @students = school_class.students
    @semester_id = school_class.teacher.semester_id
  end

end
