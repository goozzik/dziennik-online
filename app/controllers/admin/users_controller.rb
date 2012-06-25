#coding: utf-8
class Admin::UsersController < ApplicationController

  before_filter :authenticate_admin!
  before_filter :check_current_password, :only => [:update_password]
  before_filter :set_user_school_id, :only => [:create]

  def index
    @user = User.new
    @admins = current_admin.school.admins
    @teachers = current_admin.school.teachers
    @directors = current_admin.school.directors
  end

  def edit
    @user = User.find_by_id_and_school_id(params[:id], current_admin.school_id)
  end

  def create
    @user = User.new(params[:user])
    @user.save_with_role ? redirect_to(admin_users_path) : render("new")
  end

  def update
    @user = User.find_by_id_and_school_id(params[:id], current_admin.school_id)
    @user.update_attributes(params[:user]) ? redirect_to(admin_users_path) : render("edit")
  end

  def destroy
    user = User.find_by_id_and_school_id(params[:id], current_admin.school_id)
    redirect_to admin_users_path if user.destroy
  end

  def new_password
    @user = User.find_by_id_and_school_id(params[:id], current_admin.school_id)
  end

  def update_password
    @user = User.find_by_id_and_school_id(params[:id], current_admin.school_id)
    @user.update_password(params[:user]) ? redirect_to(:action => "index") : render(:action => "new_password")
  end

  private 

    def check_current_password
      unless current_admin.valid_password?(params[:user][:current_password])
        flash[:error] = "Nieprawidłowe hasło!"
        redirect_to :back
      end
    end

    def set_user_school_id
      params[:user][:school_id] = current_admin.school_id
    end

end
