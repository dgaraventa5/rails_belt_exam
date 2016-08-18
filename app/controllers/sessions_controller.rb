class SessionsController < ApplicationController
  # login and reg page, have user for form helper
  def new
  end

  # login
  def create
  	@borrower = Borrower.find_by(email: params[:email])

    if @borrower
    	if @borrower.authenticate(params[:password]) == false
        flash[:errors] = "Wrong password."
    		redirect_to "/online_lending/login"
    	else
    		session[:user_id] = @borrower.id
    		redirect_to "/online_lending/borrower/#{@borrower.id}"
    	end
    else
      @lender = Lender.find_by(email: params[:email])
      if @lender
        if @lender.authenticate(params[:password]) == false
          flash[:errors] = "Wrong password."
          redirect_to "/online_lending/login"
        else
          session[:user_id] = @lender.id
          redirect_to "/online_lending/lender/#{@lender.id}"
        end
      else
        flash[:errors] = "Email doesn't exist."
        redirect_to "/online_lending/login"
      end
    end
  end


  # logout 
  def destroy
  	reset_session
    redirect_to '/'
  end
end
