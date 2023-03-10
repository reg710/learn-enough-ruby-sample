class ApplicationController < ActionController::Base
  # By including the helper at this level, all controllers will have access to it
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url, status: :see_other
    end
  end
end
