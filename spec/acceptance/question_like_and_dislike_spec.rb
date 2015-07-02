require_relative '../acceptance_helper'

feature 'Question like or dislike', %q{
  I order to mark question
  As an user
  I want to select good or bad question
} do
  given(:users) { create_list(:user, 2) }
  given(:question) { create(:question, user: users[0]) }

  scenario 'User try to like or dislike his question', js: true do
    sign_in(users[0])
    visit question_path(question)

    within '.votes' do
      expect(page).to_not have_link 'like'
      expect(page).to_not have_link 'dislike'
    end
  end

  scenario 'User try to like other\'s question', js: true do
    sign_in(users[1])
    visit question_path(question)

    within '.votes' do
      click_on 'like'
      expect(page).to have_content 'Likes: 1'
    end
  end

  scenario 'User try to dislike other\'s question', js: true do
    sign_in(users[1])
    visit question_path(question)

    within '.votes' do
      click_on 'dislike'
      expect(page).to have_content 'Likes: -1'
    end
  end

  scenario 'Non-authenticated user try to like or dislike some question', js: true do
    visit question_path(question)

    within '.votes' do
      expect(page).to_not have_link 'like'
      expect(page).to_not have_link 'dislike'
    end
  end

  before { question.votes.create(user: users[1], like: 1) }

  scenario 'User try to cancel his vote', js: true do
    sign_in(users[1])

    visit question_path(question)

    within '.votes' do
      click_on 'Отменить выбор'
      expect(page).to have_content 'Likes: 0'
    end
  end
end
