class MainController < ApplicationController
  def index 
    @users = current_user
  end
end
