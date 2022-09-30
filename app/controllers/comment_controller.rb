class CommentController < ApplicationController
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
      redirect_to user_post_path(user_id: current_user.id, id: post.id)
    else
      flash.now[:error] = 'Error: Comment creation failed'
      render :show, locals: { post: }
    end
  end
end
