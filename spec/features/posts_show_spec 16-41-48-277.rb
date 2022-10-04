require 'rails_helper' # rubocop:todo Naming/FileName

RSpec.describe 'Post index page', type: :system do
  describe 'GET /postss/index' do
    before(:each) do
      @user1 = User.create(name: 'John',
                           photo: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80',
                           bio: 'John is a great person.')
      @post1 = Post.create(title: 'Post 1', text: 'This is the first post.', author: @user1)
      @post2 = Post.create(title: 'Post 2', text: 'This is the second post.', author: @user1)
      @post3 = Post.create(title: 'Post 3', text: 'This is the third post.', author: @user1)
      @post4 = Post.create(title: 'Post 4', text: 'This is the fourth post.', author: @user1)

      @comment1 = Comment.create(text: 'This is the first comment.', author: @user1, post: @post1)
      @comment2 = Comment.create(text: 'This is the second comment.', author: @user1, post: @post1)
      @comment3 = Comment.create(text: 'This is the third comment.', author: @user1, post: @post1)

      @post1.save
      @post2.save
      @user1.save

      @comment1.save
      @comment2.save
      @comment3.save
    end

    feature 'User index page' do # rubocop:todo Metrics/BlockLength
      background do
        user = User.find_by(name: 'John')
        id = user.id
        visit user_post_path(id, @post_1.id)
      end

      it 'displays a post\'s Title' do
        sleep(3)
        expect(page).to have_content('Post 1')
      end

      it 'displays a post\'s author' do
        sleep(3)
        expect(page).to have_content('John')
      end

      it 'displays a post\'s body' do
        sleep(3)
        expect(page).to have_content('This is the first post.')
      end

      it 'displays how many comments the post has' do
        sleep(3)
        expect(page).to have_content('Comments: 3')
      end

      it 'displays how many likes the post has' do
        sleep(3)
        expect(page).to have_content('Likes: 0')
      end

      it 'displays the user name of each comment' do
        sleep(3)
        expect(page).to have_content('John')
      end

      it 'displays the comment text' do
        sleep(3)
        expect(page).to have_content('This is the first comment.')
      end
    end
  end
end
