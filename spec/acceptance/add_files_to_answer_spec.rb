require_relative '../acceptance_helper'

feature 'Add files to answer', %q{
    To illustrate my answer
    As an question's author
    I'd like to be able to attach files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  background do

    sign_in(user)
    visit question_path(question)
  end

  scenario 'User add file when add answer', js: true do

    fill_in 'Напишите свой ответ', with: 'МойРедкийОтвет'
    attach_file 'Файл', "#{Rails.root}/spec/rails_helper.rb"
    click_on 'Ответить'

    expect(page).to have_content 'rails_helper.rb'
  end

end