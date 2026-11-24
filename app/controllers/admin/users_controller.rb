class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :authorize_resource

  def index
    @users = User.all.order(created_at: :desc)
  end

  private

  def authorization_resource
    [:admin, User]
  end
end
