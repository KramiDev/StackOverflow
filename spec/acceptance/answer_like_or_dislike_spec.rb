require_relative '../acceptance_helper'

feature 'Answer like or dislike', %q{
  In order to vote good or bad answer
  As an user
  I want to like or dislike answer
} do
  given!(:users){ create_list(:user, 2) }
  given!(:question){ create(:question) }
  given!(:answer){ create(:answer, question: question, user: users[0]) }

  scenario 'User try like or dislike his answer' do
    sign_in(users[0])
    visit question_path(question)

    within '.answer-votes' do
      expect(page).to_not have_link 'like'
      expect(page).to_not have_link 'dislike'
    end
  end

  scenario 'User try to like other\'s answer', js: true do
    sign_in(users[1])
    visit question_path(question)

    within '.answer-votes' do
      click_on 'like'
      expect(page).to have_content 'Likes: 1'
    end
  end

  scenario 'User try to dislike other\'s answer', js: true do
    sign_in(users[1])
    visit question_path(question)

    within '.answer-votes' do
      click_on 'dislike'
      expect(page).to have_content 'Likes: -1'
    end
  end

  scenario 'Non-authenticated user try to like or dislike answer' do
    visit question_path(question)

    within '.answer-votes' do
      expect(page).to_not have_link 'like'
      expect(page).to_not have_link 'dislike'
    end
  end

  before { answer.votes.create(user: users[1], like: 1) }

  scenario 'User try to cancel his vote', js: true do
    sign_in(users[1])

    visit question_path(question)

    within '.answer-votes' do
      click_on 'Отменить выбор'
      expect(page).to have_content 'Likes: 0'
    end
  end
end
