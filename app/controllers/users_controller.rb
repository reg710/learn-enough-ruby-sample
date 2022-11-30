class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])

    # Using the byebug gem, this will pause in the console 
    # allowing you to interactively test things out 
    # debugger
  end

  def new
    @user = User.new
  end

  def create
    # This is not permitted by default because
    # it would allow user to send in any data to user model
    # use strong parameters as below
    # @user = User.new(params[:user])

    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the sample app!"
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
