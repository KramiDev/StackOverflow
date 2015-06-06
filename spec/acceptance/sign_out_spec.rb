require 'rails_helper'

feature 'The user to be able to log out' do

  given(:user) { create(:user) }

  scenario 'User try to log out' do

    sign_in(user)

    click_on 'Выйти'

    expect(page).to have_content 'Signed out successfully.'

  end

end