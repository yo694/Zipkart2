class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :authorize_resource

  def index
    @pagy,@users = pagy(User.all.order(created_at: :desc),limit: 5)
  end

  private

  def authorization_resource
    [:admin, User]
  end
end
