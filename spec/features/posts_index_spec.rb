require 'rails_helper'

RSpec.describe 'Post index page', type: :system do
  describe 'GET /posts/index' do
    before(:each) do
      @user_1 = User.create(name:'John',photo: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80',bio:'John is a great person.')

      @post_1 = Post.create(title:'Post 1',text:'This is the first post.',author:@user_1)
      @post_2 = Post.create(title:'Post 2',text:'This is the second post.',author:@user_1)
      @post_3 = Post.create(title:'Post 3',text:'This is the third post.',author:@user_1)
      @post_4 = Post.create(title:'Post 4',text:'This is the fourth post.',author:@user_1)
      
      @comment_1 = Comment.create(text:'This is the first comment.',author:@user_1,post:@post_1)
      @comment_2 = Comment.create(text:'This is the second comment.',author:@user_1,post:@post_1)
      @comment_3 = Comment.create(text:'This is the third comment.',author:@user_1,post:@post_1)
      
      @post_1.save
      @post_2.save
      @user_1.save

      @comment_1.save
      @comment_2.save
      @comment_3.save
    end
    
     feature 'User index page' do
      background { 
        id = User.find_by(name: 'John').id
        visit user_posts_path(id)}
      it 'displays a list of users' do
        expect(page).to have_content('John')
      end
      it 'Displays a profile image for each user' do
        expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80']")
      end

      it 'Displays the number of posts each user has written' do
        expect(page).to have_content('Number of Posts: 4')
      end
       
         it 'displays a user\'s all posts' do
        expect(page).to have_content('Post 1')
        expect(page).to have_content('Post 2')
        expect(page).to have_content('Post 3')
        expect(page).to have_content('Post 4')
      end

      it'displays a post\'s Title' do
        expect(page).to have_content('Post 3')
      end

      it'displays a post\'s body' do
        expect(page).to have_content('This is the third post.')
      end
    
      it 'When a post is clicked it will redirect to post show page' do
        click_link('Post 3')
        user = User.find_by(name: 'John')
        id = user.id
        expect(page.current_path).to eq user_post_path(id, @post_3.id)
      end

      it 'displays how many comments the post has' do
        expect(page).to have_content('Comments: 3')
      end
       
       it'displays a see all posts button' do
        expect(page).to have_button('pagination')
      end
  
      it 'displays how many likes the post has' do
        expect(page).to have_content('Likes: 0')
      end

      it 'displays the user name of each comment' do
        expect(page).to have_content('John')
      end

      it 'displays the comment text' do
        expect(page).to have_content('This is the first comment.')
      end
     end
  end
