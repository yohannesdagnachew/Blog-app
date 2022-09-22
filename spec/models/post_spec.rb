require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = User.new(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')
    @post = Post.new(title: 'Movie', text: 'Post text', author: @user)
  end

  it 'it should create a post' do
    expect(@post).to be_valid
  end

  it 'title shold be present' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'The post title length should be below 250 characters' do
    @post.title = 'a' * 251
    expect(@post).to_not be_valid
  end

  it 'at first post_counter should be 1' do
    @post.update_posts_counter
    expect(@user.post_counter).to eq(1)
  end
end
