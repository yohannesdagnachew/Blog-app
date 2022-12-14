require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = User.new(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')
    @post = Post.new(title: 'Movie', text: 'Post text', author: @user)
    @like = Like.new(post: @post, author: @user)
  end

  it 'it should create a like' do
    expect(@like).to be_valid
  end
end
