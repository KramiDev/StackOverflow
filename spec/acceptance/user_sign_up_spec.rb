require_relative '../acceptance_helper'

feature 'Sign up', %q{
  In order to be able create questions and answers
  As an user
  I want to be able to sign up
} do
  scenario 'Non-registered user try to sign up' do
    visit new_user_registration_path
    fill_in 'Email', with: 'myemail@example.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Зарегистрироваться'

    open_email 'myemail@example.com'
    current_email.click_link 'Confirm my account'

    clear_email

    within '.notice' do
      expect(page).to have_content 'Your email address has been successfully confirmed.'
    end
    expect(current_path).to eq new_user_session_path
  end

  given!(:user) { create(:user) }

  scenario 'Registered user try to sign up' do
    sign_up(user)
    visit new_user_registration_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Зарегистрироваться'

    expect(page).to have_content 'Email has already been taken'
  end

  scenario 'Authenticated user try to sign up' do
    sign_in(user)
    visit new_user_registration_path

    expect(page).to have_content 'You are already signed in.'
    expect(current_path).to eq root_path
  end
end