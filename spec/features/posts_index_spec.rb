require 'rails_helper'

RSpec.describe 'Post index page', type: :system do
  describe 'GET /postss/index' do
    before(:each) do
      @user_1 = User.create(name:'John',photo: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80',bio:'John is a great person.')

      @post_1 = Post.create(title:'Post 1',text:'This is the first post.',author:@user_1)
      @post_2 = Post.create(title:'Post 2',text:'This is the second post.',author:@user_1)
      @post_3 = Post.create(title:'Post 3',text:'This is the third post.',author:@user_1)
      @post_4 = Post.create(title:'Post 4',text:'This is the fourth post.',author:@user_1)
    end
  end
