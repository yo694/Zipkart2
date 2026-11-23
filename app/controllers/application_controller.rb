class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

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

  def authorize_resource
    authorize authorization_resource
  end

  def authorization_resource
    raise NotImplementedError, "Define authorization_resource in the controller"
  end

  def record_not_found
    render plain: "Record not found.", status: :not_found
  end

end
