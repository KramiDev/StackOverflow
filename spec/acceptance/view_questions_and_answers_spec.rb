require_relative '../acceptance_helper'

feature 'View questions and answers', %q{
  In order to be able to view questions
  As an guest
  I want to to be able to find solution
} do

  given!(:questions) { create_list(:question, 2) }
  given!(:answers) { create_list(:answer, 2, question: questions[0]) }

  scenario 'Guest can view questions_list' do

    visit questions_path

    questions.each do |question|
      expect(page).to have_link question.title
    end

  end

  scenario 'Guest can view question and answers' do

    visit question_path(questions[0])

    expect(page).to have_content questions[0].title
    expect(page).to have_content questions[0].body

    questions[0].answers.each do |answer|
      expect(page).to have_content answer.body
    end

  end

end