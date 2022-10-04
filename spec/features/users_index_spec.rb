require 'rails_helper'

RSpec.describe 'User index page', type: :system do
  describe 'GET /users/index' do
    before(:each) do
      @user_1 = User.create(name: 'John', # rubocop:todo Naming/VariableNumber
                            photo: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80',
                            bio: 'John is a great person.')
      @user_2 = User.create(name: 'Jane', # rubocop:todo Naming/VariableNumber
                            # rubocop:todo Layout/LineLength
                            photo: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80', bio: 'Jane is a great person.')
      # rubocop:enable Layout/LineLength

      # rubocop:todo Naming/VariableNumber
      @post_1 = Post.create(title: 'Post 1', text: 'This is the first post.', author: @user_1)
      # rubocop:enable Naming/VariableNumber

      # rubocop:todo Naming/VariableNumber
      @post_2 = Post.create(title: 'Post 2', text: 'This is the second post.', author: @user_2)
      # rubocop:enable Naming/VariableNumber
      # rubocop:todo Naming/VariableNumber
      @post_3 = Post.create(title: 'Post 3', text: 'This is the third post.', author: @user_2)
      # rubocop:enable Naming/VariableNumber
      @post_1.save
      @post_2.save
      @user_1.save
      @user_2.save
    end

    feature 'User index page' do
      background { visit users_path }
      it 'displays a list of users' do
        sleep(3)
        expect(page).to have_content('John')
        expect(page).to have_content('Jane')
      end
      it 'Displays a profile image for each user' do
        sleep(3)
        expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80']")
        expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80']")
      end

      it 'Displays the number of posts each user has written' do
        sleep(3)
        expect(page).to have_content('Number of Posts: 1')
        expect(page).to have_content('Number of Posts: 2')
      end
      it 'When user clicked it will redirect to user show page' do
        sleep(3)
        click_on 'John'
        id = User.find_by(name: 'John').id
        expect(page.current_path).to eq user_path(id)
      end
    end
  end
end
