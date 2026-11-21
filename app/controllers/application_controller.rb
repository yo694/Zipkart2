class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :permitted_parameters, if: :devise_controller?

  private

  def permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone])
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_root_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def pundit_user
    if controller_path.start_with?("admin/")
      current_admin
    else
      current_user
    end
  end
end