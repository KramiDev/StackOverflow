require_relative '../acceptance_helper'

feature 'Search', js: true do
  let!(:user_list) { create_list(:user, 2) }
  let!(:questions_list) { create_list(:question, 2) }
  let!(:answers_list) { create_list(:answer, 2, question: questions_list[1]) }

  before { questions_list[0].comments.create!(body: 'NewComment') }

  scenario 'Search question', sphinx: true do
    ThinkingSphinx::Test.run do
      visit root_path
      select('Question', from: 'resource')
      fill_in 'query', with: questions_list[0].title
      click_on 'Save changes'
      
      within '.search' do
        expect(page).to have_content questions_list[0].title
      end
    end
  end

  scenario 'Search answer', sphinx: true do
    ThinkingSphinx::Test.run do
      visit root_path
      select('Answer', from: 'resource')
      fill_in 'query', with: answers_list[0].body
      click_on 'Save changes'
      
      within '.search' do
        expect(page).to have_content answers_list[0].body
      end      
    end
  end

  scenario 'Search comment', sphinx: true do
    ThinkingSphinx::Test.run do
      visit root_path
      select('Comment', from: 'resource')
      fill_in 'query', with: 'NewComment'
      click_on 'Save changes'
      
      within '.search' do
        expect(page).to have_content 'NewComment'
      end
    end
  end

  scenario 'Search user', sphinx: true do
    ThinkingSphinx::Test.run do
      visit root_path
      select('User', from: 'resource')
      fill_in 'query', with: user_list[0].email
      click_on 'Save changes'
      
      within '.search' do
        expect(page).to have_content user_list[0].email
      end
    end
  end
end