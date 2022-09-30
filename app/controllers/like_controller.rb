class LikeController < ApplicationController
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
end
