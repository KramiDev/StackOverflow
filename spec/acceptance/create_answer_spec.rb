require 'rails_helper'

feature 'Create answer', %q{
  In order to be able to help other users
  As an user
  I want to create answer
 } do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'Authenticated user create answer' do

    sign_in(user)

    visit question_path(question)
    fill_in 'Напишите свой ответ', with: 'МойРедкийОтвет'
    click_on 'Ответить'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'МойРедкийОтвет'

  end

  scenario 'Non-authenticated user try to create answer' do

    visit question_path(question)
    expect(page).to_not have_content 'Ответить'

  end

end