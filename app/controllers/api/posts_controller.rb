class Api::PostsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id)
    render json: { status: 'SUCCESS', messages: 'Load comments for a give post', data: @posts }, status: :ok
  end
end
