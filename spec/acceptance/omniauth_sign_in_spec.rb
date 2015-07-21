require_relative '../acceptance_helper'

feature 'Omniauth sign in', %q{
  In order to have easily sign_in
  As an user
  I want to be able to sign_in with social networks
} do

  background { OmniAuth.config.test_mode = true }

  scenario 'Sign in with facebook' do
    sign_in_facebook

    visit new_user_session_path
    click_on 'Sign in with Facebook'

    within '.notice' do
      expect(page).to have_content 'Successfully authenticated from facebook account.'
    end
  end

  scenario 'sign in with  provider twitter' do
    sign_in_twitter

    visit new_user_session_path
    click_on 'Sign in with Twitter'

    fill_in 'Введите свой email', with: 'test@example.com'
    click_on 'Отправить'

    open_email 'test@example.com'
    current_email.click_link 'Confirm my account'
    clear_emails

    expect(page).to have_content 'Your email address has been successfully confirmed.'
    click_on 'Sign in with Twitter'

    within '.notice' do
      expect(page).to have_content 'Successfully authenticated from twitter account.'
    end
  end
end