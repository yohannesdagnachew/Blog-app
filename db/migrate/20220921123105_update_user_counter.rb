class UpdateUserCounter < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :post_counter, :integer, default: 0
    change_column :posts, :like_counter, :integer, default: 0
    change_column :posts, :comment_counter, :integer, default: 0
  end
end
