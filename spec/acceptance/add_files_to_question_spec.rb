require_relative '../acceptance_helper'

feature 'Add files to question', %q{
    To illustrate my question
    As an question's author
    I'd like to be able to attach files
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User add file when ask question', js: true do
    within '#new_question' do
      fill_in 'Сформулируйте суть своего вопроса', with: 'Заголовок для вопроса'
      fill_in 'Опишите подробно свой вопрос', with: 'Тело для вопроса'
      click_on 'Добавить файл'
      click_on 'Добавить файл'
      inputs = all('input[type="file"]')
      inputs[0].set("#{Rails.root}/spec/spec_helper.rb")
      inputs[1].set("#{Rails.root}/spec/rails_helper.rb")
      click_on 'Задать вопрос'
    end

    expect(page).to have_link 'spec_helper.rb', "/uploads/attachment/file/1/spec_helper.rb"
    expect(page).to have_link 'rails_helper.rb',  "/uploads/attachment/file/1/rails_helper.rb"
  end
end