require_relative '../acceptance_helper'

feature 'Sign out', %q{
  In order to be able to secure own account
  As an user
  I want to be able to sign out
} do

  given(:user) { create(:user) }
  background { sign_in(user) }

  scenario 'Authenticated user try to sign out' do

    visit root_path
    click_on 'Выйти'
    expect(page).to have_content 'Signed out successfully.'

    visit new_user_session_path

    expect(current_path).to eq new_user_session_path

  end


end