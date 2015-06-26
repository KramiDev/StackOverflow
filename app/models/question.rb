class Question < ActiveRecord::Base
  include Modules::Helpers::SearchHelper

  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true
  has_many :votes, as: :voteable, dependent: :destroy
  belongs_to :user


  validates :title, :body, :user_id, presence: true
  validates :title, length: { minimum: 3, maximum: 150 }

  def best_answer
    self.answers.where(best: true).first
  end

end
