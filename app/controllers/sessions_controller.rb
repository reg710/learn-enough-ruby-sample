class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # this is equivalent to user && user.authenticate(params[:session][:password])
    if user&.authenticate(params[:session][:password])
      reset_session # protection from a 'session fixation' attack
      remember user
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
end
