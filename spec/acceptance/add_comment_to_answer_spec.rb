require_relative '../acceptance_helper'

feature 'Add comment to the answer', %q{
  In order to discuss the answer
  As an user
  I want to be able to comment the answer
} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'User add comment to answer' do
    sign_in(:user)
    visit question_path(question)

    within '.answer .comment-block' do
      click_on 'Добавить комментарий'
      fill_in 'Комментарий', with: 'NewComment'
      click_on 'Сохранить'
    end

    within '.answer .comments' do
      expect(page).to have_content 'NewComment'
    end
  end

  scenario 'Non-authenticated user try add comment to answer' do
    visit question_path(question)

    within '.answer .comment-block' do
      expect(page).to_not have_link 'Добавить комментарий'
    end
  end
end
