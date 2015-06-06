require 'rails_helper'

feature 'Create question', %q{
    In order to get answer from community
    As an authenticated user
    I want to be able to ask question
} do

  given(:user) { create(:user) }

  scenario 'The authenticated user try to create question' do

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit questions_path
    click_on 'Задать вопрос'
    fill_in 'Сформулируйте суть своего вопроса', with: 'Test question'
    fill_in 'Опишите подробно свой вопрос', with: 'Test body'
    click_on 'Задать вопрос'

    expect(page).to have_content 'Ваш вопрос успешно создан'
    expect(page).to have_content 'Test question'
    expect(page).to have_content 'Test body'

  end

  scenario 'Non-authenticated user try to create question' do

    visit questions_path

    expect(page).to_not have_link 'Задать вопрос'

  end

end