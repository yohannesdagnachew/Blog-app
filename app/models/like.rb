class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post, class_name: 'Post', foreign_key: :post_id

  after_create :update_likes_counter
  def update_likes_counter
    Post.find(post_id).increment!(:like_counter)
  end

  def decreament_likes_counter
    Post.find(post_id).decrement!(:like_counter)
  end
end
