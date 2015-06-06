require 'rails_helper'

feature 'The user create answer', %q{
        For helping other users
} do

  given(:question) { create(:question) }
  given(:user) { create(:user) }

  scenario 'Authenticated user try to create answer' do

    sign_in(user)

    visit question_path(question)
    fill_in 'Напишите свой ответ', with: 'Мой ответ'
    click_on 'Добавить ответ'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'Ваш ответ добавлен'

  end

  scenario 'Non-authenticate user try to create answer' do

    visit question_path(question)

    expect(page).to_not have_link 'Мой ответ'


  end

end