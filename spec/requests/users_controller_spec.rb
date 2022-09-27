require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  before(:each) do
    get users_path
  end

  describe 'GET /users' do
    it 'check status' do
      expect(response).to have_http_status(200)
    end
    it 'returns a list of users' do
      expect(response.body).to include('Here is a list of users in the app.')
    end
    it 'renders a show.html.erb template' do
      expect(response).to render_template('index')
    end
  end

  describe 'GET /users/1' do
    it 'check status for single user' do
      expect(response).to have_http_status(200)
    end

    it 'returns a single user' do
      get '/users/1'
      expect(response.body).to include('Here is a user for a given id.')
    end

    it 'renders a show.html.erb template' do
      get '/users/1'
      expect(response).to render_template('show')
    end
  end
end
