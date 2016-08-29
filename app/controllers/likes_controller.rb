class LikesController < ApplicationController

	before_action :require_login

	def create
		like = Like.create(post: Post.find(params[:post_id]), user: User.find(session[:user_id]))
		redirect_to :back
	end
end
