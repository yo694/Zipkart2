class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :authorize_resource
  
  def index
    users = User.all.order(created_at: :desc)
    if params[:search].present?
      search = params[:search].strip
      search = "%#{User.sanitize_sql_like(search)}%"
      users = users.where(
        "name LIKE ? OR email LIKE ?",
        search,
        search
        )
    end
    @pagy, @users = pagy(users, limit: 10)
  end

  private

  def authorization_resource
    [:admin, User]
  end
end
