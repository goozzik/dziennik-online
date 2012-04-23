class ApplicationController < ActionController::Base

  protect_from_forgery

  def current_teacher
    Teacher.find(current_user.id)
  end

  private

    # Overwriting the sign_in redirect path method
    def after_sign_in_path_for(resource_or_scope)
      root_path
    end

end
