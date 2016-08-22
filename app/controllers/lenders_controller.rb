class LendersController < ApplicationController

	def create
		@lender = Lender.new(lender_params)
		if @lender.save
			session[:user_id] = @lender.id
			redirect_to "/online_lending/lender/#{@lender.id}" 
		else
			flash[:lender_errors] = @lender.errors.full_messages
			redirect_to "/online_lending/register"
		end	
	end

	def show
		@lender = Lender.find(session[:user_id])

		@borrowers_not_lent = History.find_by_sql("SELECT * FROM borrowers GROUP BY borrowers.id")

		@borrowers_lent = History.find_by_sql("SELECT histories.amount 'amount', borrowers.first_name 'first_name', borrowers.last_name 'last_name', borrowers.purpose 'purpose', borrowers.description 'description', borrowers.money 'money', borrowers.raised 'raised' FROM histories JOIN borrowers ON histories.borrower_id = borrowers.id WHERE histories.lender_id = #{@lender.id} GROUP BY borrowers.id")
	end




	private
	def lender_params
		params.require(:lender).permit(:first_name, :last_name, :email, :password, :money)	
	end

end