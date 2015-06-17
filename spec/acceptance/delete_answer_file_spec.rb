require_relative '../acceptance_helper'

feature 'Delete file', %q{
  In order to be able to destroy file
  As an author
} do

  given!(:user){ create(:user) }
  given!(:question){ create(:question, user: user) }

  background do
    sign_in(user)
    create_answer_upload_file(question)
  end

  scenario 'Author delete own file', js: true do

    within '.answers' do
      click_on 'Удалить файл'
    end

    expect(page).to_not have_link 'rails_helper.rb', href: "/uploads/attachment/file/1/rails_helper.rb"

  end

end