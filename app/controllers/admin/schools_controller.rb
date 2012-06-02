class Admin::SchoolsController < ApplicationController

  before_filter :authenticate_admin!

  def show
    @semester = Semester.new
    @semesters = current_admin.school.semesters
  end

end
