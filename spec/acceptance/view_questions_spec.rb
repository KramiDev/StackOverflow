require 'rails_helper'

feature 'User view questions', %q{
  In order to be able view questions
} do


  scenario 'All users and guests to be able to view all questions' do

    questions = create_list(:question, 2)

    visit questions_path

    questions.each do |quest|
      expect(page).to have_link quest.title
    end

  end

  scenario 'All users and guests can to be able to view question and answers' do

    question = Question.create(attributes_for(:question))
    question.answers.build(attributes_for(:answer))

    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body

    question.answers.each do |answer|
      expect(page).to have_content answer.body
    end

  end

end