require_relative '../acceptance_helper'

feature 'Create question', %q{
  In order to be able to find a solution problem
  As an user
  I want to be able to create a question
} do
  given!(:user) { create(:user) }

  scenario 'Authenticated user try to create question', js: true do
    sign_in(user)

    visit questions_path
    click_on 'Задать вопрос'

    within '#new_question' do
      fill_in 'Сформулируйте суть своего вопроса', with: 'Заголовок для вопроса'
      fill_in 'Опишите подробно свой вопрос', with: 'Тело для вопроса'
      click_on 'Задать вопрос'
    end

    expect(page).to have_content 'Заголовок для вопроса'
    expect(page).to have_content 'Тело для вопроса'
  end

  scenario 'Non-authenticated user try to create question', js: true do
    visit questions_path
    expect(page).to_not have_link 'Задать вопрос'
  end
end