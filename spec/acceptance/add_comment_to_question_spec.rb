require_relative '../acceptance_helper'

feature 'Add comment to the question', %q{
  In order to be discuss the question
  As an user
  I want to add comment to the question
} do
  given!(:question) { create(:question) }
  given!(:user) { create(:user) }

  scenario 'Authenticated user try to add comment', js: true do
    sign_in(user)
    visit question_path(question)

    within '.question-comments' do
      click_on 'Добавить комментарий'
      fill_in 'Комментарий', with: 'NewComment'
      click_on 'Сохранить'
      expect(page).to have_content 'NewComment'
    end
  end

  scenario 'Non-authenticated user try to add comment' do
    visit question_path(question)
    expect(page).to_not have_link 'Добавить комментарий'
  end
end