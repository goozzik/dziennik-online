class Admin::AdminController < ApplicationController

  before_filter :authenticate_admin!

  private

    def authenticate_admin!
      authenticate_user!
      redirect_to root_path unless current_user.admin?
    end

end
