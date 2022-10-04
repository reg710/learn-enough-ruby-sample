class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    # Using the byebug gem, this will pause in the console 
    # allowing you to interactively test things out 
    # debugger
  end

  def new
    debugger
  end
end
