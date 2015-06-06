require 'rails_helper'

feature 'User delete answer', %q{
  User can delete only own answer
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'User can delete only own answer' do

    sign_in(user)

    visit question_path(question)

    click_on 'Удалить ответ'

    expect(page).to have_content 'Ваш ответ удален'

  end

  scenario 'User try delete other answer' do

    visit question_path(question)

    expect(page).to_not have_link 'Удалить ответ'

  end


end