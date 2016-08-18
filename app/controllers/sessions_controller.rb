class SessionsController < ApplicationController
  # login and reg page, have user for form helper
  def new
  end

  # login
  def create
  	@user = User.find_by(email: params[:email])
    if @user.authenticate(params[:password]) == false
      redirect_to "/"
    else
      session[:user_id] = @user.id
      redirect_to "/events"
    end
  end

  # logout 
  def destroy
  	reset_session
    redirect_to '/'
  end
end
