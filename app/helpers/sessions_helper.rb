module SessionsHelper
  # Logs in the given user
  # session is a built in rails method that includes encryption
  def log_in(user)
    session[:user_id] = user.id
    # Guard against session replay attacks
    session[:session_token] = user.session_token
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
      user = User.find_by(id: user_id)
      if user && session[:session_token] == user.session_token
        @current_user = user
      end
    elsif (user_id = cookies.encrypted[:user_id])
      # raise # use this as a way to test if a section of code is covered by tests
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if the given user is the current user
  def current_user?(user)
    user && user == current_user
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

  # Stores URL a user is trying to access
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
