class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
    @user_data = User.find(params[:user_id])
    @current_user_id = current_user.id
  end

  def new_comment
    comment = Comment.new
    respond_to do |format|
      format.html { render :new_comment, locals: { comment: } }
    end
  end

  def create_comment
    comment_text = params.require(:comment).permit(:text)[:text]
    post = Post.where(author_id: current_user.id).where(id: params[:id])[0]
    user = User.find(current_user.id)
    new_comment = Comment.new(post:, author: user, text: comment_text)

    new_comment.save
    puts new_comment.errors.full_messages
    if new_comment.save
      new_comment.update_comments_counter
      flash[:success] = 'Success: Comment created successfully'
      redirect_to user_posts_path(user_id: current_user.id, id: post.id)
    else
      flash.now[:error] = 'Error: Comment creation failed'
      render :show, locals: { post: }
    end
  end

  def like
    post = Post.all.find(params[:id])
    user = current_user
    if Like.where(post:, author_id: user.id).count.zero?
      flash.now[:success] = 'Success: Post liked successfully'
      like = Like.create(post:, author_id: user.id) # rubocop:todo Lint/UselessAssignment

    else
      flash[:success] = 'Success: you disliked this post'
      like = Like.where(post:, author_id: user.id)[0]
      like.decreament_likes_counter
      like.destroy
    end

    redirect_to user_post_path(user_id: current_user.id)
  end

  def show
    @posts = Post.where(author_id: params[:user_id]).where(id: params[:id])[0]
    @current_user_id = current_user.id
    puts @posts
  end

  def new
    new_post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: new_post } }
    end
  end

  def create
    new_post = Post.new(params.require(:post).permit(:title, :text))
    new_post.author_id = current_user.id
    new_post.save

    respond_to do |format|
      format.html do
        if new_post.save
          # Success message
          flash.now[:success] = 'Post created successfully'
          redirect_to user_posts_path(current_user.id)
        else
          # Error message
          flash.now[:error] = 'Error: Post creation failed'
          render :new, locals: { post: new_post }
        end
      end
    end
  end
end
