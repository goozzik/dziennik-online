#coding: utf-8
class Admin::UsersController < ApplicationController

  before_filter :authenticate_admin!
  before_filter :user, :only => [:edit, :new_password]
  before_filter :check_current_password, :only => [:update_password]

  def index
  end

  def edit
  end

  def create
    user.save_with_role ? redirect_to(admin_users_path) : render("new")
  end

  def update
    user.update_attributes(params[:user]) ? redirect_to(admin_users_path) : render("edit")
  end

  def destroy
    user.destroy && redirect_to(admin_users_path)
  end

  def new_password
  end

  def update_password
    user.update_password(params[:user]) ? redirect_to(action: "index") : render(action: "new_password")
  end

  private

    def check_current_password
      unless current_admin.valid_password?(params[:user][:current_password])
        flash[:error] = "Nieprawidłowe hasło!"
        redirect_to :back
      end
    end

    def user
      if params[:id]
        @user ||= current_admin.users.find(params[:id])
      else
        @user ||= current_admin.users.build(params[:user])
      end
    end

end
