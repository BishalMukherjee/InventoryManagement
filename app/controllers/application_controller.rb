class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }
  before_action :set_auth

  private

  def current_user
    @current_user = Admin.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
  
  def set_auth
    @auth = session[:omniauth] if session[:omniauth]
  end
end
