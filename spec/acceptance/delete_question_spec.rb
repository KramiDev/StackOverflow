require 'rails_helper'

feature 'User delete question' do


  scenario 'User can delete only own question' do

    user = User.create(attributes_for(:user))

    sign_in(user)

    question = user.questions.create(attributes_for(:question))

    visit question_path(question)

    click_on 'Удалить вопрос'

    expect(page).to have_content 'Ваш вопрос удален'
    expect(current_path).to eq questions_path

  end

  scenario 'User try delete other question' do


    question = create(:question)

    visit question_path(question)

    expect(page).to_not have_link 'Удалить вопрос'

  end

end