require_relative '../acceptance_helper'

feature 'Delete answer' do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, user: user, question: question) }

  scenario 'Authenticated user try to delete answer', js: true do

    sign_in(user)

    visit question_path(question)
    click_on 'Удалить ответ'

    expect(current_path).to eq question_path(question)
    expect(page).to_not have_content answer.body

  end

  scenario 'Non-authenticated user try to delete answer' do

    visit question_path(question)
    expect(page).to_not have_content 'Удалить ответ'

  end


end