class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
    @user_data = User.find(params[:user_id])
  end

  def show
    @posts = Post.where(author_id: params[:user_id]).where(id: params[:id])[0]
  end
end
