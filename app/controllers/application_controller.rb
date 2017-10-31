class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  $default_rate = 100

  Time::DATE_FORMATS[:medium] = "%d %b %Y %H:%M"

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
