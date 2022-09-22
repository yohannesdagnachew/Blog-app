require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = User.new(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')
    @post = Post.new(title: 'Movie',text: 'Post text', author: @user)
    @comment =  Comment.new(post: @post, author: @user, text: 'Hi Jonny!' )
  end

  it 'it should create a comment' do
    expect(@comment).to be_valid
  end

  it 'it should create a comment' do
    @comment.update_comments_counter
    expect(@post.comment_counter).to eq(1)
  end
end