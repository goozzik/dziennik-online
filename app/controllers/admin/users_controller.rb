#coding: utf-8
class Admin::UsersController < ApplicationController

  before_filter :authenticate_admin!
  before_filter :role_filter, :only => [:create]

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
    user.destroy
    redirect_to admin_users_path
  end

  private 

    def role_filter
      unless params[:user][:user_role].empty?
        unless Admin::AVAILABLE_ROLES.include?(params[:user][:user_role])
          flash[:alert] = "Błąd!"
          redirect_to :back
        end
      end
    end

end
