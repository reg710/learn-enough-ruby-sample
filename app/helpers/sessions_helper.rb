module SessionsHelper

    # Logs in the given user
    # session is a built in rails method that includes encryption
    def log_in(user)
        session[:user_id] = user.id 
    end

    def current_user
        # if @current_user.nil?
        #     @current_user = User.find_by(id: session[:user_id])
        # else
        #     @current_user
        # end

        # This does the same as above, but is not idiomatic
        # @current_user = @current_user || User.find_by(id: session[:user_id])

        if session[:user_id]
            # Apparently this is the nonsense I need to get familiar with
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    def logged_in?
        !current_user.nil?
    end
end
