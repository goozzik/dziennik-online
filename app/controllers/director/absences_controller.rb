class Director::AbsencesController < ApplicationController

  before_filter :authenticate_director!
  before_filter :director_school_class_has_students?

  def index
    @month = Chronic.parse('monday this month', :now => (params[:date].nil? ? Time.now : Time.parse(params[:date])))
    @weeks = Absence.get_weeks_from_month(@month)
    @previous_month = Chronic.parse('monday last month', :now => @month)
    @next_month = Chronic.parse('monday next month', :now => @month)
  end


end
