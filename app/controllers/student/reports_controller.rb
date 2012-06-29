class Student::ReportsController < ApplicationController

  before_filter :authenticate_student!

  def index
  end

end

