require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }
  end

  describe 'for admin' do
    let(:user) { create(:user, admin: true) }

    it { should be_able_to :manage, :all }
    it { should be_able_to :read, :all }
  end

  describe 'for user' do
    let!(:user) { create(:user) }
    let!(:non_author) { create(:user) }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }
    it { should be_able_to :create, Vote }
    it { should be_able_to :destroy, Vote }

    it { should be_able_to :update, create(:question, user: user), user: user }
    it { should_not be_able_to :update, create(:question, user: non_author), user: user }

    it { should be_able_to :update, create(:answer, user: user), user: user }
    it { should_not be_able_to :update, create(:answer, user: non_author), user: user }

    it { should be_able_to :update, create(:comment, user: user), user: user }
    it { should_not be_able_to :update, create(:comment, user: non_author), user: user }

    context 'for best and cancel' do
      let(:question) { create(:question, user: user) }
      let(:answer) { create(:answer, question: question) }

      it { should be_able_to :best, answer }
      it { should_not be_able_to :best, answer.question.update!(user: non_author) }
    end
  end
end