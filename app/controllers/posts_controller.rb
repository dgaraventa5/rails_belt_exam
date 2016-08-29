class PostsController < ApplicationController

  before_action :require_login

  def index
  	@user = User.find(session[:user_id])
  	@posts = Post.find_by_sql("SELECT posts.id 'id', posts.user_id, posts.content 'content', COUNT(likes.id) 'num_of_likes' FROM posts LEFT JOIN likes ON posts.id = likes.post_id GROUP BY posts.id ORDER BY COUNT(likes.id) DESC")
  end

  def show
    @post = Post.find(params[:post_id])
    @post_likes = Like.find_by_sql("SELECT users.id 'user_id', likes.user_id, users.alias 'alias', users.name 'name' FROM likes JOIN users ON likes.user_id = users.id WHERE likes.post_id = #{@post.id} GROUP BY likes.user_id")
  end

  def create
  	@post = Post.create(content: params[:content], user: User.find(session[:user_id]))
  	redirect_to :back
  end

  def destroy
  	post = Post.find(params[:post_id]).destroy
  	redirect_to :back
  end
end
