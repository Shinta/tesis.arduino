class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  def get_current_user
    @current_user = User.includes(:profile).find_by_id(session[:user])
  end
end
