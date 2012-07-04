class Admin::SemestersController < ApplicationController

  before_filter :authenticate_admin!

  def create
    semester.save ? redirect_to(:controller => "schools", :action => "show") : render(:action => "new")
  end

  def destroy
    semester.destroy && redirect_to(:controller => "schools", :action => "show")
  end

  def activate
    semester.activate && redirect_to(:controller => "schools", :action => "show")
  end

  private
  
    def semester
      if params[:id]
        @semester ||= current_admin.semesters.find(params[:id])
      else
        @semester ||= current_admin.semesters.build(params[:semester])
      end
    end

end
