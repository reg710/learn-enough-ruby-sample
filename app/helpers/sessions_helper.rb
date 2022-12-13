module SessionsHelper
  # Logs in the given user
  # session is a built in rails method that includes encryption
  def log_in(user)
    session[:user_id] = user.id
  end

  # Rememeber a user in a persistent session
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    # if @current_user.nil?
    #     @current_user = User.find_by(id: session[:user_id])
    # else
    #     @current_user
    # end

    # This does the same as above, but is not idiomatic
    # @current_user = @current_user || User.find_by(id: session[:user_id])

    # Apparently this is the nonsense I need to get familiar with
    # @current_user ||= User.find_by(id: session[:user_id])

    # Be careful to remember this is not a comparison but an assignment
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  # Forgets a persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user
  def log_out
    forget(current_user)
    reset_session
    @current_user = nil
  end
end
