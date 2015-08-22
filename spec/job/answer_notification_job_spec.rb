require 'rails_helper'

RSpec.describe AnswerNotificationJob, type: :job do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:subscribe) { create(:subscribe, user: user, question: question) }
  let(:answer) { create(:answer, question: question) }

  it 'Send email notification' do
    question.subscribes.each do |sub|
      expect(AnswerNotification).to receive(:send_mail).with(sub.user, sub.question).and_call_original
    end
    AnswerNotificationJob.perform_now(answer)
  end

end