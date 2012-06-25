class Admin::SemestersController < ApplicationController

  before_filter :authenticate_admin!

  def create
    @semester = current_admin.school.semesters.build(params[:semester])
    @semester.save ? redirect_to(:controller => "schools", :action => "show") : render(:action => "new")
  end

  def destroy
    semester = current_admin.school.semesters.find(params[:id])
    semester.destroy
    redirect_to(:controller => "schools", :action => "show")
  end

  def activate
    semester = current_admin.school.semesters.find(params[:id])
    semester.activate
    redirect_to(:controller => "schools", :action => "show")
  end

end
