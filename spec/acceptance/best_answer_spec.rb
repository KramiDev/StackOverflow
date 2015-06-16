require_relative '../acceptance_helper'

feature 'Best answer', %q{
  In order to point solution for me
  As an author of question
  I want to select best answer
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'Author select best answer', js: true do

    sign_in(user)

    visit question_path(question)

    within('.answers') do
      click_on 'Выбрать лучшим'
    end

    expect(page).to have_content 'Отмечен решением'
    expect(page).to_not have_content 'Выбрать лучшим'

  end

end