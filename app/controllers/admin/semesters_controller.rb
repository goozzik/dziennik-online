class Admin::SemestersController < ApplicationController

  before_filter :authenticate_admin!

  def create
    @semester = current_admin.school_semesters.build(params[:semester])
    @semester.save ? redirect_to(:controller => "schools", :action => "show") : render(:action => "new")
  end

  def activate
    semester = current_admin.school_semesters.find(params[:id])
    semester.activate
    redirect_to(:controller => "schools", :action => "show")
  end

end
