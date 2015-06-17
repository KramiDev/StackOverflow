require_relative '../acceptance_helper'

feature 'Edit answer', %q{
  In order to fix mistake in answer
  As an author
  I want to edit my answer
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }


  describe 'Author' do

    before do
      user
      question
      answer

      sign_in(user)
    end

    scenario 'Author to view edit link' do

      visit question_path(question)

      within '.answers' do
        expect(page).to have_link 'Редактировать'
      end

    end

    scenario 'Author change answer', js: true do

      visit question_path(question)

      within '.answers' do
        click_on 'Редактировать'
        fill_in 'Ответ', with: 'TestTest'
        click_on 'Сохранить'
      end

      expect(page).to_not have_content answer.body
      expect(page).to have_content 'TestTest'

    end

  end


  given!(:user1) { create(:user) }

  scenario 'User try edit other answer' do

    sign_in(user1)

    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link 'Редактировать'
    end

  end


end