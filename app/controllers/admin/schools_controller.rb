class Admin::SchoolsController < ApplicationController

  before_filter :authenticate_admin!

  def show
    @semester = current_admin.school_semesters.new
    @semesters = current_admin.school_semesters
  end

end
