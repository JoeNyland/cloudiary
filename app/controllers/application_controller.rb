class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include ActionView::Helpers::UrlHelper

  private

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in.<br>If you don't already have an account, #{link_to('click here', new_user_path).html_safe} to get started!"
      redirect_to login_url
    end
  end

end
