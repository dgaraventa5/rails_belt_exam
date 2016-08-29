class SessionsController < ApplicationController
  # login and reg page, have user for form helper
  def new
  end

  # login
  def create
  	@user = User.find_by(email: params[:email])

    if @user
      if @user.authenticate(params[:password]) == false
        flash[:login_errors] = "Wrong email/password combination. Please try again."
        redirect_to :back
      else
        session[:user_id] = @user.id
        redirect_to '/bright_ideas'
      end
    else
        flash[:login_errors] = "Email doesn't exist."
        redirect_to :back
    end
  end


  # logout 
  def destroy
  	reset_session
    redirect_to '/'
  end
end
