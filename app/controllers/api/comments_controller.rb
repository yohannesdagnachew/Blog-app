class Api::CommentsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

    def index
      @post = Post.where(author_id: params[:user_id], id: params[:post_id])
      @comments = Comment.where(post: @post)
      render json: {status: 'SUCCESS', messages: 'Load comments', data: @comments}, status: :ok
    end

    def create
      comment_text = params.require(:comment).permit(:title)[:text]
      post = Post.where(author_id: params[:user_id], id: params[:post_id])
  
      @new_comment = Comment.new(post: post, author: current_user, text: comment_text)
      @new_comment.save
      render json: {status: 'SUCCESS', messages: 'Create new', data: @comments}, status: :ok
      render json: @new_comment, status: :created
    end
end