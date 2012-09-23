class Director::AbsencesController < ApplicationController

  before_filter :authenticate_director!, :director_school_class_has_students?

  def index
    @month = Absence.parse_first_monday(params[:date].nil? ? Time.now : Time.parse(params[:date]))
    @weeks = Absence.get_weeks_from_month(@month)
    @previous_month = Absence.parse_monday_last_month('monday last month', :now => @month)
    @next_month = Absence.parse_monday_next_month('monday next month', :now => @month)
  end

end
