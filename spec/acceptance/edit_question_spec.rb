require_relative '../acceptance_helper'

feature 'Edit question', %q{
  In order to be fix question
  As an author
  I want to edit my question
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  describe 'Author try to edit own question' do

    before { sign_in(user) }

    scenario 'Author to have link edit' do

      visit question_path(question)

      within '.question-block' do
        expect(page).to have_link 'Редактировать'
      end

    end

    scenario 'Edit with valid attributes', js: true do

      visit question_path(question)
      within '.question-block' do
        click_on 'Редактировать'
        fill_in 'Сформулируйте суть своего вопроса', with: 'TestTest'
        click_on 'Сохранить'
      end

      expect(page).to_not have_content question.body
      expect(page).to have_content 'TestTest'

    end

  end

  given!(:user1){ create(:user) }

  scenario 'Non-author try to edit question' do

    sign_in(user1)

    visit question_path(question)

    within '.question-block' do
      expect(page).to_not have_content 'Редактировать'
    end

  end



end