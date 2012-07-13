class Admin::SchoolsController < ApplicationController

  before_filter :authenticate_admin!

  def show
    @semesters = current_admin.semesters
    @semester = Semester.new
  end

end
