#coding: utf-8
class Admin::UsersController < ApplicationController

  before_filter :authenticate_admin!
  before_filter :role_filter, :only => [:create]
  before_filter :check_current_password, :only => [:update_password]

  def index
    @user = User.new
    @admins = current_admin.school.admins
    @teachers = current_admin.school.teachers
    @directors = current_admin.school.directors
  end

  def create
    case params[:user][:user_role]
      when "nauczyciel"
        @user = current_admin.school.teachers.build(params[:user])
      when "dyrektor"
        @user = current_admin.school.directors.build(params[:user])
      when "administrator"
        @user = current_admin.school.admins.build(params[:user])
      else
        @user = User.new(params[:user])
    end
    @user.save ? redirect_to(admin_users_path) : render("new")
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

    def role_filter
      unless params[:user][:user_role].empty?
        unless Admin::AVAILABLE_ROLES.include?(params[:user][:user_role])
          flash[:error] = "Nieprawidłowy typ!"
          redirect_to :back
        end
      end
    end

    def check_current_password
      unless current_admin.valid_password?(params[:user][:current_password])
        flash[:error] = "Nieprawidłowe hasło!"
        redirect_to :back
      end
    end

end
