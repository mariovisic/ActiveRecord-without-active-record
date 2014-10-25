require 'spec_helper'

describe 'my application' do
  it 'allows users to sign up' do
    visit root_path
    click_link 'Sign Up'

    fill_in 'Username', :with => 'joe'
    fill_in 'Password', :with => 'secure'
    fill_in 'Password confirmation', :with => 'secure'
    fill_in 'Email', :with => 'joe@bloggs.com'
    click_button 'Register'

    expect(page).to have_content 'Well done joe, registration complete'
    expect(open_last_email_for('joe@bloggs.com').body.to_s).to include 'Welcome to my application'
  end

  it 'prevents unauthenticated users from viewing posts' do
    visit posts_path
    expect(page).to have_content 'You need to be logged in to view this page'
  end

  context 'when the user has an account' do
    let!(:user) { User.create!(username: 'joe', hashed_password: BCrypt::Password.create('super secure'), email: 'joe@io.co') }

    it 'allows them to login' do
      visit root_path
      click_link 'Login'

      fill_in 'Username', :with => 'joe'
      fill_in 'Password', :with => 'super secure'
      click_button 'Login'

      expect(page).to have_content 'Well done joe, successfully logged in'
    end

    it 'allows them to create posts' do
      visit root_path
      click_link 'Login'

      fill_in 'Username', :with => 'joe'
      fill_in 'Password', :with => 'super secure'
      click_button 'Login'

      click_link 'New Post'

      fill_in 'Title', :with => 'My first post'
      fill_in 'Body', :with => 'It is a long story'
      click_button 'Create Post'

      expect(Post.last.title).to eq 'My first post'
      expect(Post.last.body).to eq 'It is a long story'
      expect(open_last_email_for('joe@io.co').body.to_s).to include 'joe has created a new post'
    end
  end
end
