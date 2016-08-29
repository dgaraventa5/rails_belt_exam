class UsersController < ApplicationController

	before_action :require_login, only: [:show]

	def show
		@user = User.find(params[:id])
		@num_of_posts = User.find(params[:id]).posts.count
		@num_of_likes = User.find(params[:id]).posts_liked.count
	end


	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to "/bright_ideas"
		else
			flash[:register_errors] = @user.errors.full_messages
			redirect_to :back
		end
	end



	private 
		def user_params
			params.require(:user).permit(:name, :alias, :email, :password, :password_confirmation)
		end

end
