require_relative '../acceptance_helper'

feature 'Delete question' do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'Authenticated user try to delete question' do
    sign_in(user)

    visit question_path(question)
    click_on 'Удалить вопрос'
    expect(current_path).to eq questions_path
    expect(page).to have_content 'Ваш вопрос удален'
  end

  scenario 'Non-authenticated user try to delete question' do
    visit question_path(question)
    expect(page).to_not have_content 'Удалить вопрос'
  end
end