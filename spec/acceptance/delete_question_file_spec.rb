require_relative '../acceptance_helper'

feature 'Delete file', %q{
  In order to be able to destroy file
  As an author
} do
  given!(:user) { create(:user) }

  background do
    sign_in(user)
    create_question_upload_file
  end

  scenario 'Author delete own file', js: true do
    click_on 'Удалить файл'
    expect(page).to_not have_link 'rails_helper.rb', href: "/uploads/attachment/file/1/rails_helper.rb"
  end
end