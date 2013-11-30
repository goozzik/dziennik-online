# coding: utf-8
class Admin::SemestersController < Admin::AdminController

  before_filter :semester_is_archived?, :only => [:activate]
  before_filter :semester_is_active?, :only => [:archive]

  def create
    semester.save ? redirect_to(controller: "schools", action: "show") : render(action: "new")
  end

  def destroy
    semester.destroy && redirect_to(controller: "schools", action: "show")
  end

  def activate
    semester.activate && redirect_to(controller: "schools", action: "show")
  end

  def archive
    semester.archive && redirect_to(controller: "schools", action: "show")
  end

  def unarchive
    semester.unarchive && redirect_to(controller: "schools", action: "show")
  end

  private

    def semester
      if params[:id]
        @semester ||= current_admin.semesters.find(params[:id])
      else
        @semester ||= current_admin.semesters.build(params[:semester])
      end
    end

    def semester_is_archived?
      if semester.archived
        flash[:error] = "Nie można aktywować zarchiwizowanego semestru!"
        redirect_to(controller: "schools", action: "show")
      end
    end

    def semester_is_active?
      if semester.active
        flash[:error] = "Nie można zarchiwizować aktywnego semestru!"
        redirect_to(controller: "schools", action: "show")
      end
    end

end
