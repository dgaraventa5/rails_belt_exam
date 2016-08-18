class BorrowersController < ApplicationController

	def new	
	end

	def create
		@borrower = Borrower.new(borrower_params)
		if @borrower.save
			session[:user_id] = @borrower.id
			redirect_to "/online_lending/borrower/<%=@borrower.id%>"
		else
			flash[:borrower_errors] = @borrower.errors.full_messages
			redirect_to "/online_lending/register"
		end
	end


	def show
		@borrower = Borrower.find(session[:user_id])
		@history = History.find_by_sql("SELECT histories.amount 'amount', lenders.first_name 'first_name', lenders.last_name 'last_name', lenders.email 'email' FROM histories JOIN lenders ON histories.lender_id = lenders.id WHERE histories.borrower_id = #{@borrower.id}")
	end

	private
	def borrower_params
		params.require(:borrower).permit(:first_name, :last_name, :email, :password, :purpose, :description, :money, :raised)
	end


end
