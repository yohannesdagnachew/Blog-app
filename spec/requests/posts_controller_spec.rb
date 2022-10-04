require 'rails_helper'

RSpec.describe 'PostController', type: :request do
  describe 'GET /users/1/posts' do
    before(:each) do
      user = User.create(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')
      get user_posts_path(user)
    end
    it 'check status' do
      expect(response).to have_http_status(200)
    end
    it 'returns a list of posts for a given user' do
      expect(response.body).to include('Here is a list of posts for a given user.')
    end
    it 'renders the index.html.erb template' do
      expect(response).to render_template('index')
    end
  end

  describe 'GET /users/1/posts/1' do
    before(:each) do
      user = User.create(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')
      post = Post.create(title: 'Movie', text: 'Post text', author: user)
      get user_post_path(user.id, post.id)
    end
    it 'check status' do
      expect(response).to have_http_status(200)
    end
    it 'returns a single post for a given user' do
      expect(response.body).to include('Here is a post for a given user and id of the post.')
    end

    it 'renders the show.html.erb template' do
      expect(response).to render_template('show')
    end
  end
end
