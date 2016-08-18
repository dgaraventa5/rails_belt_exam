class HistoriesController < ApplicationController
  def create

    lender = Lender.find(session[:user_id])

    if lender.money <= 0 || lender.money < params[:amount].to_i
      flash[:error] = "Insufficient funds"
      redirect_to "/online_lending/lender/#{session[:user_id]}"
    else
      lender_new_money = lender.money - params[:amount].to_i
      lender.update(money: lender_new_money)

      history = History.create(amount: params[:amount], lender: Lender.find(session[:user_id]), borrower: Borrower.find(params[:borrower_id]))

      borrower = Borrower.find(params[:borrower_id])
      borrower_new_money = borrower.money - params[:amount].to_i
      borrower_new_raised = borrower.raised + params[:amount].to_i
      borrower.update(money: borrower_new_money, raised: borrower_new_raised)

      redirect_to "/online_lending/lender/#{session[:user_id]}"
    end
  end
end
