require 'rails_helper'

RSpec.describe User, type: :model do
  subject {User.new(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')}
  
  it 'it should create a user' do
    expect(subject).to be_valid
  end

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should be present' do
  post = Post.create(title: 'Post1', text: 'Hello rails', author: subject)
  post.update_posts_counter
    expect(subject.post_counter).to eq(2)
  end

end
