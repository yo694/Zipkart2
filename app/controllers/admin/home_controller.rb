class Admin::HomeController < ApplicationController
    before_action :authenticate_admin!
    
    def index
        authorize  [:admin, :home], :index?
    end

end

