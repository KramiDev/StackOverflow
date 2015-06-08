require 'rails_helper'

feature 'Sign in', %q{
  In order to be able to create questions and answers
  As an user
  I want to sign in
} do

  given!(:user) { create(:user) }

  scenario 'Registered user try to sign in' do

    sign_in(user)

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path

  end

  scenario 'Non-registered user try to sign in' do

    visit new_user_session_path
    fill_in 'Email', with: 'asd@asd.com'
    fill_in 'Password', with: 'asdasdqwe'
    click_on 'Войти'

    expect(page).to have_content 'Invalid email or password.'
    expect(current_path).to eq new_user_session_path

  end

end